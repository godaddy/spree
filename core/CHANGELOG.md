## Spree 2.2.5 (unreleased) ##
* Provided hooks for extensions to seamlessly integrate with the order population workflow.
  Extensions make use of the convention of passing parameters during the 'add to cart' 
  action https://github.com/spree/spree/blob/master/core/app/models/spree/order_populator.rb#L12
  with a prefix like [:options][:voucher_attributes] (in the case of the spree_vouchers 
  extension).  The extension then provides some methods named according to what was passed in 
  like:
  
  https://github.com/spree-contrib/spree_vouchers/blob/master/app/models/spree/order_decorator.rb#L51
  
  to determine if these possible line item customizations affect the line item equality condition and
  
  https://github.com/spree-contrib/spree_vouchers/blob/master/app/models/spree/variant_decorator.rb#L3
  
  to adjust a line item's price if necessary.
  
  https://github.com/spree/spree/blob/master/core/app/models/spree/order_contents.rb#L70
  shows how we expect inbound parameters (such as the voucher_attributes) to be saved in a 
  nested_attributes fashion.
  
    Jeff Squires
