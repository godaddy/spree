require 'spec_helper'

describe Spree::LineItem do
  let(:order) { create :order_with_line_items, line_items_count: 1 }
  let(:line_item) { order.line_items.first }

  context '#save' do
    it 'touches the order' do
      line_item.order.should_receive(:touch)
      line_item.save
    end
  end

  context '#destroy' do
    it "fetches deleted products" do
      line_item.product.destroy
      expect(line_item.reload.product).to be_a Spree::Product
    end

    it "fetches deleted variants" do
      line_item.variant.destroy
      expect(line_item.reload.variant).to be_a Spree::Variant
    end

    it "returns inventory when a line item is destroyed" do
      Spree::OrderInventory.any_instance.should_receive(:verify).with(line_item, nil)
      line_item.destroy
    end
  end

  context "#save" do
    context "line item changes" do
      before do
        line_item.quantity = line_item.quantity + 1
      end

      it "triggers adjustment total recalculation" do
        line_item.should_receive(:update_tax_charge) # Regression test for https://github.com/spree/spree/issues/4671
        line_item.should_receive(:recalculate_adjustments)
        line_item.save
      end
    end

    context "line item does not change" do
      it "does not trigger adjustment total recalculation" do
        line_item.should_not_receive(:recalculate_adjustments)
        line_item.save
      end
    end
  end

  context "#create" do
    let(:variant) { create(:variant) }

    before do
      create(:tax_rate, :zone => order.tax_zone, :tax_category => variant.tax_category)
    end

    context "when order has a tax zone" do
      before do
        order.tax_zone.should be_present
      end

      it "creates a tax adjustment" do
        order.contents.add(variant)
        line_item = order.find_line_item_by_variant(variant)
        line_item.adjustments.tax.count.should == 1
      end
    end

    context "when order does not have a tax zone" do
      before do
        order.bill_address = nil
        order.ship_address = nil
        order.save
        order.reload.tax_zone.should be_nil
      end

      it "does not create a tax adjustment" do
        order.contents.add(variant)
        line_item = order.find_line_item_by_variant(variant)
        line_item.adjustments.tax.count.should == 0
      end
    end
  end

  # Test for #3391
  context '#copy_price' do
    it "copies over a variant's prices" do
      line_item.price = nil
      line_item.cost_price = nil
      line_item.currency = nil
      line_item.copy_price
      variant = line_item.variant
      line_item.price.should == variant.price
      line_item.cost_price.should == variant.cost_price
      line_item.currency.should == variant.currency
    end
  end

  # Test for #3481
  context '#copy_tax_category' do
    it "copies over a variant's tax category" do
      line_item.tax_category = nil
      line_item.copy_tax_category
      expect(line_item.tax_category).to eq(line_item.variant.tax_category)
    end
  end

  describe '.discounted_amount' do
    it "returns the amount minus any discounts" do
      line_item.price = 10
      line_item.quantity = 2
      line_item.promo_total = -5
      line_item.discounted_amount.should == 15
    end
  end

  describe '.currency' do
    it 'returns the globally configured currency' do
      line_item.currency == 'USD'
    end
  end

  describe ".money" do
    before do
      line_item.price = 3.50
      line_item.quantity = 2
    end

    it "returns a Spree::Money representing the total for this line item" do
      line_item.money.to_s.should == "$7.00"
    end
  end

  describe '.single_money' do
    before { line_item.price = 3.50 }
    it "returns a Spree::Money representing the price for one variant" do
      line_item.single_money.to_s.should == "$3.50"
    end
  end

  context "has inventory (completed order so items were already unstocked)" do
    let(:order) { Spree::Order.create }
    let(:variant) { create(:variant) }

    context "nothing left on stock" do
      before do
        variant.stock_items.update_all count_on_hand: 5, backorderable: false
        order.contents.add(variant, 5)
        order.create_proposed_shipments
        order.finalize!
      end

      it "allows to decrease item quantity" do
        line_item = order.line_items.first
        line_item.quantity -= 1
        line_item.target_shipment = order.shipments.first

        line_item.save
        expect(line_item).to have(0).errors_on(:quantity)
      end

      it "doesnt allow to increase item quantity" do
        line_item = order.line_items.first
        line_item.quantity += 2
        line_item.target_shipment = order.shipments.first

        line_item.save
        expect(line_item).to have(1).errors_on(:quantity)
      end
    end

    context "2 items left on stock" do
      before do
        variant.stock_items.update_all count_on_hand: 7, backorderable: false
        order.contents.add(variant, 5)
        order.create_proposed_shipments
        order.finalize!
      end

      it "allows to increase quantity up to stock availability" do
        line_item = order.line_items.first
        line_item.quantity += 2
        line_item.target_shipment = order.shipments.first

        line_item.save
        expect(line_item).to have(0).errors_on(:quantity)
      end

      it "doesnt allow to increase quantity over stock availability" do
        line_item = order.line_items.first
        line_item.quantity += 3
        line_item.target_shipment = order.shipments.first

        line_item.save
        expect(line_item).to have(1).errors_on(:quantity)
      end
    end
  end

  context "currency same as order.currency" do
    it "is a valid line item" do
      line_item = order.line_items.first
      line_item.currency = order.currency
      line_item.valid?

      expect(line_item).to have(0).error_on(:currency)
    end
  end

  context "currency different than order.currency" do
    it "is not a valid line item" do
      line_item = order.line_items.first
      line_item.currency = "no currency"
      line_item.valid?

      expect(line_item).to have(1).error_on(:currency)
    end
  end

  context "validations" do
    context "price" do
      it "has a maximum value of 999_999.99" do
        line_item.price = '1_000_000'
        line_item.valid?
        expect(line_item.errors[:price].size).to eq 1
        line_item.price = '999_999.99'
        line_item.valid?
        expect(line_item.errors[:price].size).to eq 0
      end

      it "has a minimum value of 0" do
        line_item.price = '-1'
        line_item.valid?
        expect(line_item.errors[:price].size).to eq 1
        line_item.price = '0'
        line_item.valid?
        expect(line_item.errors[:price].size).to eq 0
      end
    end

    context "cost_price" do
      it "has a maximum value of 999_999.99" do
        line_item.cost_price = '1_000_000'
        line_item.valid?
        expect(line_item.errors[:cost_price].size).to eq 1
        line_item.cost_price = '999_999.99'
        line_item.valid?
        expect(line_item.errors[:cost_price].size).to eq 0
      end

      it "has a minimum value of 0" do
        line_item.cost_price = '-1'
        line_item.valid?
        expect(line_item.errors[:cost_price].size).to eq 1
        line_item.cost_price = '0'
        line_item.valid?
        expect(line_item.errors[:cost_price].size).to eq 0
      end
    end

    context "adjustment_total" do
      it "has a maximum value of 99_999_999.99" do
        line_item.adjustment_total = '100_000_000'
        line_item.valid?
        expect(line_item.errors[:adjustment_total].size).to eq 1
        line_item.adjustment_total = '99_999_999.99'
        line_item.valid?
        expect(line_item.errors[:adjustment_total].size).to eq 0
      end

      it "has a minimum value of -99_999_999.99" do
        line_item.adjustment_total = '-100_000_000'
        line_item.valid?
        expect(line_item.errors[:adjustment_total].size).to eq 1
        line_item.adjustment_total = '-99_999_999.99'
        line_item.valid?
        expect(line_item.errors[:adjustment_total].size).to eq 0
      end
    end

    context "additional_tax_total" do
      it "has a maximum value of 99_999_999.99" do
        line_item.additional_tax_total = '100_000_000'
        line_item.valid?
        expect(line_item.errors[:additional_tax_total].size).to eq 1
        line_item.additional_tax_total = '99_999_999.99'
        line_item.valid?
        expect(line_item.errors[:additional_tax_total].size).to eq 0
      end

      it "has a minimum value of 0" do
        line_item.additional_tax_total = '-1'
        line_item.valid?
        expect(line_item.errors[:additional_tax_total].size).to eq 1
        line_item.additional_tax_total = '0.0'
        line_item.valid?
        expect(line_item.errors[:additional_tax_total].size).to eq 0
      end
    end

    context "promo_total" do
      it "has a maximum value of 99_999_999.99" do
        line_item.promo_total = '100_000_000'
        line_item.valid?
        expect(line_item.errors[:promo_total].size).to eq 1
        line_item.promo_total = '99_999_999.99'
        line_item.valid?
        expect(line_item.errors[:promo_total].size).to eq 0
      end

      it "has a minimum value of 0" do
        line_item.promo_total = '-1'
        line_item.valid?
        expect(line_item.errors[:promo_total].size).to eq 1
        line_item.promo_total = '0'
        line_item.valid?
        expect(line_item.errors[:promo_total].size).to eq 0
      end
    end

    context "included_tax_total" do
      it "has a maximum value of 99_999_999.99" do
        line_item.included_tax_total = '100_000_000'
        line_item.valid?
        expect(line_item.errors[:included_tax_total].size).to eq 1
        line_item.included_tax_total = '99_999_999.99'
        line_item.valid?
        expect(line_item.errors[:included_tax_total].size).to eq 0
      end

      it "has a minimum value of 0" do
        line_item.included_tax_total = '-1'
        line_item.valid?
        expect(line_item.errors[:included_tax_total].size).to eq 1
        line_item.included_tax_total = '0'
        line_item.valid?
        expect(line_item.errors[:included_tax_total].size).to eq 0
      end
    end

    context "pre_tax_amount" do
      it "has a maximum value of 999_999.99" do
        line_item.pre_tax_amount = '1_000_000'
        line_item.valid?
        expect(line_item.errors[:pre_tax_amount].size).to eq 1
        line_item.pre_tax_amount = '999_999.99'
        line_item.valid?
        expect(line_item.errors[:pre_tax_amount].size).to eq 0
      end

      it "has a minimum value of 0" do
        line_item.pre_tax_amount = '-1'
        line_item.valid?
        expect(line_item.errors[:pre_tax_amount].size).to eq 1
        line_item.pre_tax_amount = '0'
        line_item.valid?
        expect(line_item.errors[:pre_tax_amount].size).to eq 0
      end
    end


  end
end
