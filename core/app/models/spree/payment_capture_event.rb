module Spree
  class PaymentCaptureEvent < ActiveRecord::Base
    belongs_to :payment, class_name: 'Spree::Payment'

    validates :amount, numericality: Spree::Core::DbValueValidations::NILLABLE_POSITIVE_DECIMAL_10_2

    def display_amount
      Spree::Money.new(amount, { currency: payment.currency })
    end
  end
end
