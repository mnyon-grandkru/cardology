# Braintree::Configuration.environment = ENV["BT_ENVIRONMENT"].to_sym
#
# if Braintree::Configuration.environment == :sandbox
#   Braintree::Configuration.merchant_id = ENV["BT_SANDBOX_MERCHANT_ID"]
#   Braintree::Configuration.public_key  = ENV["BT_SANDBOX_PUBLIC_KEY"]
#   Braintree::Configuration.private_key = ENV["BT_SANDBOX_PRIVATE_KEY"]
# else
#   Braintree::Configuration.merchant_id = ENV["BT_MERCHANT_ID"]
#   Braintree::Configuration.public_key  = ENV["BT_PUBLIC_KEY"]
#   Braintree::Configuration.private_key = ENV["BT_PRIVATE_KEY"]
# end
