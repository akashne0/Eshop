class PaypalsController < ApplicationController
  require 'paypal-sdk-rest'
  include CurrentCart  
  before_action :set_cart, only: [:new, :create]
  skip_before_action :verify_authenticity_token
  before_action :paypal_init, :except => [:new]

  def new
  end

  def create

      @order = Order.new
      @order.add_line_items_from_cart(@cart)
      request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
      request.request_body({
                        intent: "CAPTURE",
                        purchase_units: [
                            {
                                amount: {
                                    currency_code: "USD",
                                    value: (@cart.total).to_i
                                }
                            }
                        ]
                      })

      begin
          # Call API with your client and get a response for your call
          response = PayPal::PayPalHttpClient.new(PayPal::SandboxEnvironment.new(Rails.application.credentials.dig(:paypal, :paypal_client_id), Rails.application.credentials.dig(:paypal, :paypal_secret_key))).execute(request)
          # If call returns body in response, you can get the deserialized version from the result attribute of the response
          order = response.result
          puts order
      rescue PayPalHttp::HttpError => ioe
          # Something went wrong server-side
          puts ioe.status_code
          puts ioe.headers["debug_id"]
      end
    # respond_to do |format|
    #     Cart.destroy(session[:cart_id])
    #     session[:cart_id] = nil

    #     format.html { redirect_to root_url, notice: "Thankyou for your order.You paid #{@cart.total}" }
    #     format.json { render :show, status: :created, location: @order }
    # end
  end
  

  private

  def paypal_init
    client_id = Rails.application.credentials.dig(:paypal, :paypal_client_id)
    client_secret = Rails.application.credentials.dig(:paypal, :paypal_secret_key)
    environment = PayPal::SandboxEnvironment.new client_id, client_secret
    client = PayPal::PayPalHttpClient.new(environment)
  end

end
