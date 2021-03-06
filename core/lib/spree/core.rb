require 'rails/all'
require 'active_merchant'
require 'acts_as_list'
require 'awesome_nested_set'
require 'cancan'
require 'kaminari'
require 'mail'
require 'monetize'
require 'paperclip'
require 'paranoia'
require 'ransack'
require 'state_machine'
require 'friendly_id'
require 'font-awesome-rails'

module Spree

  mattr_accessor :user_class

  def self.user_class
    if @@user_class.is_a?(Class)
      raise "Spree.user_class MUST be a String or Symbol object, not a Class object."
    elsif @@user_class.is_a?(String) || @@user_class.is_a?(Symbol)
      @@user_class.to_s.constantize
    end
  end

  # Used to configure Spree.
  #
  # Example:
  #
  #   Spree.config do |config|
  #     config.site_name = "An awesome Spree site"
  #   end
  #
  # This method is defined within the core gem on purpose.
  # Some people may only wish to use the Core part of Spree.
  def self.config(&block)
    yield(Spree::Config)
  end

  module Core
    autoload :ProductFilters, "spree/core/product_filters"

    class GatewayError < RuntimeError; end
    class DestroyWithOrdersError < StandardError; end
  end
end

require 'spree/core/version'

require 'spree/core/ransackable_attributes'
require 'spree/core/mail_interceptor'
require 'spree/core/mail_method'
require 'spree/core/mail_settings'
require 'spree/core/environment_extension'
require 'spree/core/environment/calculators'
require 'spree/core/environment'
require 'spree/promo/environment'
require 'spree/migrations'
require 'spree/core/engine'

require 'spree/i18n'
require 'spree/money'

require 'spree/permitted_attributes'
require 'spree/core/user_address'
require 'spree/core/user_payment_source'
require 'spree/core/delegate_belongs_to'
require 'spree/core/permalinks'
require 'spree/core/token_resource'
require 'spree/core/calculated_adjustments'
require 'spree/core/adjustment_source'
require 'spree/core/product_duplicator'
require 'spree/core/controller_helpers'
require 'spree/core/controller_helpers/strong_parameters'
require 'spree/core/controller_helpers/ssl'
require 'spree/core/controller_helpers/search'

require 'spree/core/importer'

# TODO revisit this fix with more long term solution of replacing state_machine
# waiting on https://github.com/pluginaweek/state_machine/pull/275
# this is how Spree 2.3 resolved StateMachine version conflict issues
# it appears that Spree 3.0 resolves this by moving to state_machines-activerecord,
# which is likely a much better long term solution
module StateMachine
  module Integrations
    module ActiveModel
      public :around_validation
    end
  end
end

