module Spree
  class PaymentCaptureEvent < ActiveRecord::Base
    belongs_to :payment, class_name: 'Spree::Payment'

    validates :amount, numericality: { less_than_or_equal_to: 99999999.99, greater_than_or_equal_to: 0, allow_nil: true }

    def display_amount
      Spree::Money.new(amount, { currency: payment.currency })
    end
  end
end
