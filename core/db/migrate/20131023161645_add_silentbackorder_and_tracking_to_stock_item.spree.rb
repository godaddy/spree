class AddSilentbackorderAndTrackingToStockItem < ActiveRecord::Migration
  def change
    add_column :spree_stock_items, :silentbackorder, :boolean, :default => false, :after => :backorderable
    add_column :spree_stock_items, :tracking, :boolean, :default => true
  end
end
