# coding: UTF-8

require 'spec_helper'

describe Spree::Taxon do
  let(:taxon) { FactoryGirl.build(:taxon, :name => "Ruby on Rails") }

  context "set_permalink" do

    it "should set permalink correctly when no parent present" do
      taxon.set_permalink
      taxon.permalink.should == "ruby-on-rails"
    end

    it "should support Chinese characters" do
      taxon.name = "你好"
      taxon.set_permalink
      taxon.permalink.should == 'ni-hao'
    end

    context "with parent taxon" do
      let(:parent) { FactoryGirl.build(:taxon, :permalink => "brands") }
      before       { taxon.stub :parent => parent }

      it "should set permalink correctly when taxon has parent" do
        taxon.set_permalink
        taxon.permalink.should == "brands/ruby-on-rails"
      end

      it "should set permalink correctly with existing permalink present" do
        taxon.permalink = "b/rubyonrails"
        taxon.set_permalink
        taxon.permalink.should == "brands/rubyonrails"
      end

      it "should support Chinese characters" do
        taxon.name = "我"
        taxon.set_permalink
        taxon.permalink.should == "brands/wo"
      end

      # Regression test for #3390
      context "setting a new node sibling position via :child_index=" do
        let(:idx) { rand(0..100) }
        before { parent.stub(:move_to_child_with_index) }

        context "taxon is not new" do
          before { taxon.stub(:new_record?).and_return(false) }

          it "passes the desired index move_to_child_with_index of :parent " do
            taxon.should_receive(:move_to_child_with_index).with(parent, idx)

            taxon.child_index = idx
          end
        end
      end

    end
  end

  # Regression test for #2620
  context "creating a child node using first_or_create" do
    let(:taxonomy) { create(:taxonomy) }

    it "does not error out" do
      expect { taxonomy.root.children.unscoped.where(:name => "Some name").first_or_create }.not_to raise_error
    end
  end

  context "destroy" do
    let(:taxon) { FactoryGirl.create(:taxon, :name => "Something") }
    let(:product1) { create(:product) }
    let(:product2) { create(:product) }

    before do
      product1.update_column(:updated_at, 1.minutes.ago)
      product2.update_column(:updated_at, 1.minutes.ago)
      taxon.products << [product1, product2]
      expect([product1.reload, product2.reload].map(&:taxons)).to eq([[taxon], [taxon]])
    end

    it "touch associated products when deleted" do
      updated_at_1 = product1.updated_at
      updated_at_2 = product2.updated_at
      taxon.destroy
      expect([product1.reload, product2.reload].map(&:taxons)).to eq([[], []])
      expect(product1.updated_at).not_to eq(updated_at_1)
      expect(product2.updated_at).not_to eq(updated_at_2)
    end
  end
end
