Stripe.api_key = Rails.application.credentials.stripe.secret

# the same Rails.application.credentials.stripe[:secret]
# Rails.application.credentials[:stripe][:secret]
# Rails.application.credentials.dig(:stripe, :secret)