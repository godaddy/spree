module Spree
  module Core
    module ControllerHelpers
      module Zone
        def self.included(base)
          base.class_eval do
            before_action :reset_zones_cache
          end
        end

        def reset_zones_cache
          Spree::Zone.reset_zones_cache
        end
      end
    end
  end
end        