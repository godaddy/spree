module Spree
  module Core
    module AdjustmentSource
      def self.included(klass)
        klass.class_eval do
          def deals_with_adjustments_for_deleted_source
            adjustment_scope = self.adjustments.includes(:order).references(:spree_orders)

            # For incomplete orders, remove the adjustment completely.
            open_adjustments = adjustment_scope.where("spree_orders.completed_at IS NULL")
            open_orders = open_adjustments.map(&:order).uniq
            open_adjustments.destroy_all
            open_orders.each do |o|
              o.line_items.each {|l| Spree::ItemAdjustments.new(l).update}
              o.create_tax_charge! unless self.is_a? Spree::TaxRate
              o.update!
            end

            # For complete orders, the source will be invalid.
            # Therefore we nullify the source_id, leaving the adjustment in place.
            # This would mean that the order's total is not altered at all.
            adjustment_scope.where("spree_orders.completed_at IS NOT NULL").each do |adjustment|
              adjustment.update_columns(
                source_id: nil,
                updated_at: Time.now,
              )
            end
          end
        end
      end
    end
  end
end
