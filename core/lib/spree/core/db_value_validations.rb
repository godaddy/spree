module Spree
  module Core
    module DbValueValidations
      POSITIVE_MIN = { greater_than_or_equal_to: 0 }.freeze
      NEGATIVE_MAX = { less_than_or_equal_to: 0 }.freeze
      ALLOW_NIL = { allow_nil: true }.freeze

      DECIMAL_8_5_LIMIT = 999.99999
      DECIMAL_8_5_MAX = { less_than_or_equal_to: DECIMAL_8_5_LIMIT }.freeze
      POSITIVE_DECIMAL_8_5 = DECIMAL_8_5_MAX.merge(POSITIVE_MIN).freeze

      DECIMAL_8_2_LIMIT = 999_999.99
      DECIMAL_8_2_MAX = { less_than_or_equal_to: DECIMAL_8_2_LIMIT }.freeze
      DECIMAL_8_2_MIN = { greater_than_or_equal_to: -DECIMAL_8_2_LIMIT }.freeze

      POSITIVE_DECIMAL_8_2 = DECIMAL_8_2_MAX.merge(POSITIVE_MIN).freeze
      DECIMAL_8_2 = DECIMAL_8_2_MAX.merge(DECIMAL_8_2_MIN).freeze
      NILLABLE_POSITIVE_DECIMAL_8_2 = POSITIVE_DECIMAL_8_2.merge(ALLOW_NIL).freeze

      DECIMAL_10_2_LIMIT = 99_999_999.99
      DECIMAL_10_2_MAX = { less_than_or_equal_to: DECIMAL_10_2_LIMIT }.freeze
      DECIMAL_10_2_MIN = { greater_than_or_equal_to: -DECIMAL_10_2_LIMIT }.freeze

      DECIMAL_10_2 = DECIMAL_10_2_MAX.merge(DECIMAL_10_2_MIN).freeze
      NILLABLE_DECIMAL_10_2 = DECIMAL_10_2.merge(ALLOW_NIL).freeze
      POSITIVE_DECIMAL_10_2 = DECIMAL_10_2_MAX.merge(POSITIVE_MIN).freeze
      NEGATIVE_DECIMAL_10_2 = DECIMAL_10_2_MIN.merge(NEGATIVE_MAX).freeze
      NILLABLE_POSITIVE_DECIMAL_10_2 = POSITIVE_DECIMAL_10_2.merge(ALLOW_NIL).freeze
      NILLABLE_NEGATIVE_DECIMAL_10_2 = NEGATIVE_DECIMAL_10_2.merge(ALLOW_NIL).freeze

      DECIMAL_13_5_LIMIT = 99_999_999.99999
      DECIMAL_13_5_MAX = { less_than_or_equal_to: DECIMAL_13_5_LIMIT }.freeze
      DECIMAL_13_5_MIN = { greater_than_or_equal_to: -DECIMAL_13_5_LIMIT }.freeze

      DECIMAL_13_5 = DECIMAL_13_5_MAX.merge(DECIMAL_13_5_MIN).freeze
      NILLABLE_DECIMAL_13_5 = DECIMAL_13_5.merge(ALLOW_NIL).freeze
      POSITIVE_DECIMAL_13_5 = DECIMAL_13_5_MAX.merge(POSITIVE_MIN).freeze
      NEGATIVE_DECIMAL_13_5 = DECIMAL_13_5_MIN.merge(NEGATIVE_MAX).freeze
      NILLABLE_POSITIVE_DECIMAL_13_5 = POSITIVE_DECIMAL_13_5.merge(ALLOW_NIL).freeze
      NILLABLE_NEGATIVE_DECIMAL_13_5 = NEGATIVE_DECIMAL_13_5.merge(ALLOW_NIL).freeze
    end
  end
end
