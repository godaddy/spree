require 'spec_helper'

describe Spree::OrderPopulator do
  let(:order) { Spree::Order.new }
  subject { Spree::OrderPopulator.new(order, "USD") }

  context "with stubbed out find_variant" do
    let(:variant) { double('Variant', name: "T-Shirt", options_text: "Size: M") }

    before do
     Spree::Variant.stub(:find).and_return(variant)
     order.should_receive(:contents).at_least(:once).and_return(Spree::OrderContents.new(self))
    end

    context "can populate an order" do
      it "can take a list of variants with quantites and add them to the order" do
        expect(order).to receive(:ensure_updated_shipments)
        order.contents.should_receive(:add).with(variant, 5, currency: subject.currency).and_return double.as_null_object
        subject.populate(2, 5)
      end

      it "assigns `new_line_item`" do
        line_item = Spree::LineItem.new
        line_item.stub(:valid?).and_return true
        order.contents.should_receive(:add).with(variant, 5, currency: subject.currency).and_return line_item
        subject.populate(2, 5)
        expect(subject.new_line_item).to eq line_item
      end
    end
  end
end
