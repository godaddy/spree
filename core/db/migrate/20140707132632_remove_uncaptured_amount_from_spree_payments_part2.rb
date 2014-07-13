# previous migration was commented out in Nemo, so rerunning here as followup migration to remove column
class RemoveUncapturedAmountFromSpreePaymentsPart2 < ActiveRecord::Migration
  def change
    remove_column :spree_payments, :uncaptured_amount if column_exists? :spree_payments, :uncaptured_amount
  end
end
