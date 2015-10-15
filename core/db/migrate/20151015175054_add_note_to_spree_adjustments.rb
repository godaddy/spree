class AddNoteToSpreeAdjustments < ActiveRecord::Migration
  def change
    add_column :spree_adjustments, :note, :string
  end
end
