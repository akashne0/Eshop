client_secret = Rails.application.credentials.dig(:paypal, :paypal_secret_key)
client_id = Rails.application.credentials.dig(:paypal, :paypal_client_id)