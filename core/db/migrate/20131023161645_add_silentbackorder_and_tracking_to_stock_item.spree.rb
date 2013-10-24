class AddSilentbackorderAndTrackingToStockItem < ActiveRecord::Migration
  def change
    add_column :spree_stock_items, :track_inventory, :boolean, :default => true
  end
end
