class AddIndexToSpreeZonesAndSpreeZoneMembers < ActiveRecord::Migration
  def change
    add_index :spree_zones, :name, :name => 'index_spree_zones_on_name'
    add_index :spree_zones, :default_tax, :name => 'index_spree_zones_on_default_tax'
    add_index :spree_zones, [:zone_members_count, :created_at], :name => 'index_spree_zones_on_members_count_created_at'
    add_index :spree_zone_members, [:zone_id, :zoneable_id, :zoneable_type], :name => 'index_spree_zone_members_on_zone_id_zoneable'
  end
end
