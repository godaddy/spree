class AllowNullOnTimestamps < ActiveRecord::Migration
  def change

    change_column :spree_stock_items, :created_at, :datetime, :null => true
    change_column :spree_stock_items, :updated_at, :datetime, :null => true

    change_column :spree_promotion_rules, :updated_at, :datetime, :null => true
    change_column :spree_promotion_rules, :created_at, :datetime, :null => true

    change_column :spree_stock_movements, :created_at, :datetime, :null => true
    change_column :spree_stock_movements, :updated_at, :datetime, :null => true

    change_column :spree_shipping_rates, :created_at, :datetime, :null => true
    change_column :spree_shipping_rates, :updated_at, :datetime, :null => true

    change_column :spree_shipping_method_categories, :created_at, :datetime, :null => true
    change_column :spree_shipping_method_categories, :updated_at, :datetime, :null => true

    change_column :spree_addresses, :created_at, :datetime, :null => true
    change_column :spree_addresses, :updated_at, :datetime, :null => true

    change_column :spree_adjustments, :created_at, :datetime, :null => true
    change_column :spree_adjustments, :updated_at, :datetime, :null => true

    change_column :spree_calculators, :created_at, :datetime, :null => true
    change_column :spree_calculators, :updated_at, :datetime, :null => true

    change_column :spree_configurations, :created_at, :datetime, :null => true
    change_column :spree_configurations, :updated_at, :datetime, :null => true

    # change_column :spree_countries, :created_at, :datetime, :null => true
    change_column :spree_countries, :updated_at, :datetime, :null => true

    change_column :spree_credit_cards, :created_at, :datetime, :null => true
    change_column :spree_credit_cards, :updated_at, :datetime, :null => true

    change_column :spree_gateways, :created_at, :datetime, :null => true
    change_column :spree_gateways, :updated_at, :datetime, :null => true

    change_column :spree_inventory_units, :created_at, :datetime, :null => true
    change_column :spree_inventory_units, :updated_at, :datetime, :null => true

    change_column :spree_line_items, :created_at, :datetime, :null => true
    change_column :spree_line_items, :updated_at, :datetime, :null => true

    change_column :spree_log_entries, :created_at, :datetime, :null => true
    change_column :spree_log_entries, :updated_at, :datetime, :null => true

    change_column :spree_option_types, :created_at, :datetime, :null => true
    change_column :spree_option_types, :updated_at, :datetime, :null => true

    change_column :spree_option_values, :created_at, :datetime, :null => true
    change_column :spree_option_values, :updated_at, :datetime, :null => true

    change_column :spree_orders, :created_at, :datetime, :null => true
    change_column :spree_orders, :updated_at, :datetime, :null => true

    change_column :spree_payment_methods, :created_at, :datetime, :null => true
    change_column :spree_payment_methods, :updated_at, :datetime, :null => true

    change_column :spree_payments, :created_at, :datetime, :null => true
    change_column :spree_payments, :updated_at, :datetime, :null => true

    change_column :spree_preferences, :created_at, :datetime, :null => true
    change_column :spree_preferences, :updated_at, :datetime, :null => true

    change_column :spree_product_option_types, :created_at, :datetime, :null => true
    change_column :spree_product_option_types, :updated_at, :datetime, :null => true

    change_column :spree_product_properties, :created_at, :datetime, :null => true
    change_column :spree_product_properties, :updated_at, :datetime, :null => true

    change_column :spree_products, :created_at, :datetime, :null => true
    change_column :spree_products, :updated_at, :datetime, :null => true

    change_column :spree_promotions, :created_at, :datetime, :null => true
    change_column :spree_promotions, :updated_at, :datetime, :null => true

    change_column :spree_properties, :created_at, :datetime, :null => true
    change_column :spree_properties, :updated_at, :datetime, :null => true

    change_column :spree_prototypes, :created_at, :datetime, :null => true
    change_column :spree_prototypes, :updated_at, :datetime, :null => true

    change_column :spree_return_authorizations, :created_at, :datetime, :null => true
    change_column :spree_return_authorizations, :updated_at, :datetime, :null => true

    change_column :spree_shipments, :created_at, :datetime, :null => true
    change_column :spree_shipments, :updated_at, :datetime, :null => true

    change_column :spree_shipping_categories, :created_at, :datetime, :null => true
    change_column :spree_shipping_categories, :updated_at, :datetime, :null => true

    change_column :spree_shipping_methods, :created_at, :datetime, :null => true
    change_column :spree_shipping_methods, :updated_at, :datetime, :null => true

    change_column :spree_state_changes, :created_at, :datetime, :null => true
    change_column :spree_state_changes, :updated_at, :datetime, :null => true

    # change_column :spree_states, :created_at, :datetime, :null => true
    change_column :spree_states, :updated_at, :datetime, :null => true

    change_column :spree_stock_locations, :created_at, :datetime, :null => true
    change_column :spree_stock_locations, :updated_at, :datetime, :null => true

    change_column :spree_stock_transfers, :created_at, :datetime, :null => true
    change_column :spree_stock_transfers, :updated_at, :datetime, :null => true

    change_column :spree_tax_categories, :created_at, :datetime, :null => true
    change_column :spree_tax_categories, :updated_at, :datetime, :null => true

    change_column :spree_tax_rates, :created_at, :datetime, :null => true
    change_column :spree_tax_rates, :updated_at, :datetime, :null => true

    change_column :spree_taxonomies, :created_at, :datetime, :null => true
    change_column :spree_taxonomies, :updated_at, :datetime, :null => true

    change_column :spree_taxons, :created_at, :datetime, :null => true
    change_column :spree_taxons, :updated_at, :datetime, :null => true

    change_column :spree_tokenized_permissions, :created_at, :datetime, :null => true
    change_column :spree_tokenized_permissions, :updated_at, :datetime, :null => true

    change_column :spree_trackers, :created_at, :datetime, :null => true
    change_column :spree_trackers, :updated_at, :datetime, :null => true

    change_column :spree_users, :created_at, :datetime, :null => true
    change_column :spree_users, :updated_at, :datetime, :null => true

    # change_column :spree_variants, :created_at, :datetime, :null => true
    change_column :spree_variants, :updated_at, :datetime, :null => true

    change_column :spree_zone_members, :created_at, :datetime, :null => true
    change_column :spree_zone_members, :updated_at, :datetime, :null => true

    change_column :spree_zones, :created_at, :datetime, :null => true
    change_column :spree_zones, :updated_at, :datetime, :null => true

  end
end
