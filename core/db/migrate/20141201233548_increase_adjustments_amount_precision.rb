class IncreaseAdjustmentsAmountPrecision < ActiveRecord::Migration
  def up
    change_column :spree_adjustments, :amount,                :decimal, :precision => 13, :scale => 5
    change_column :spree_shipments,   :additional_tax_total,  :decimal, :precision => 13, :scale => 5
    change_column :spree_shipments,   :included_tax_total,    :decimal, :precision => 13, :scale => 5
    change_column :spree_shipments,   :adjustment_total,      :decimal, :precision => 13, :scale => 5
    change_column :spree_shipments,   :promo_total,           :decimal, :precision => 13, :scale => 5
    change_column :spree_line_items,  :additional_tax_total,  :decimal, :precision => 13, :scale => 5
    change_column :spree_line_items,  :included_tax_total,    :decimal, :precision => 13, :scale => 5
    change_column :spree_line_items,  :adjustment_total,      :decimal, :precision => 13, :scale => 5
    change_column :spree_line_items,  :promo_total,           :decimal, :precision => 13, :scale => 5
  end

  def down
    change_column :spree_adjustments, :amount,                :decimal, :precision => 10, :scale => 2
    change_column :spree_shipments,   :additional_tax_total,  :decimal, :precision => 10, :scale => 2
    change_column :spree_shipments,   :included_tax_total,    :decimal, :precision => 10, :scale => 2
    change_column :spree_shipments,   :adjustment_total,      :decimal, :precision => 10, :scale => 2
    change_column :spree_shipments,   :promo_total,           :decimal, :precision => 10, :scale => 2
    change_column :spree_line_items,  :additional_tax_total,  :decimal, :precision => 10, :scale => 2
    change_column :spree_line_items,  :included_tax_total,    :decimal, :precision => 10, :scale => 2
    change_column :spree_line_items,  :adjustment_total,      :decimal, :precision => 10, :scale => 2
    change_column :spree_line_items,  :promo_total,           :decimal, :precision => 10, :scale => 2
  end
end
