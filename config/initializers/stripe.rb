Rails.configuration.stripe = {
  :publishable_key => 'pk_test_dCdiutYbeaze5OvSDgwhz7UQ',
  :secret_key      => 'sk_test_5qkm07U5Vtwe5qvBebqZEfRq'
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]



