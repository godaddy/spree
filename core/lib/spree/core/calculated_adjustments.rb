module Spree
  module Core
    module CalculatedAdjustments
      def self.included(klass)
        klass.class_eval do
          has_one   :calculator, :class_name => "Spree::Calculator", :as => :calculable, :dependent => :destroy
          accepts_nested_attributes_for :calculator
          validates :calculator, :presence => true

          def self.calculators
            spree_calculators.send model_name_without_spree_namespace
          end

          def calculator_type
            calculator.class.to_s if calculator
          end

          def calculator_type=(calculator_type)
            klass = calculator_type.constantize if calculator_type
            self.calculator = klass.new if klass && !self.calculator.is_a?(klass)
          end

          private
          def self.model_name_without_spree_namespace
            self.to_s.tableize.gsub('/', '_').sub('spree_', '')
          end

          def self.spree_calculators
            Rails.application.config.spree.calculators
          end

          def deals_with_adjustments
            adjustment_scope = self.adjustments.includes(:order).references(:spree_orders)

            # For incomplete orders, remove the adjustment completely.
            open_adjustments = adjustment_scope.where("spree_orders.completed_at IS NULL")
            open_orders = open_adjustments.map(&:order).uniq
            open_adjustments.destroy_all
            open_orders.each {|o| o.line_items.each {|l| l.send(:recalculate_adjustments)}}
            open_orders.map(&:update!)

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
