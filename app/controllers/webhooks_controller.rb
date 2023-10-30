class WebhooksController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def create
      payload = request.body.read
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      event = nil
        begin
          event = Stripe::Webhook.construct_event(
            # payload, sig_header, Rails.application.credentials[:stripe][:webhook]
            payload, sig_header, ENV["CREDENTIALS_STIPE_WEBHOOK"]
          )
        rescue JSON::ParserError => e
            # Invalid payload
            puts "Error parsing payload: #{e.message}"
            status 400
            return
        rescue Stripe::SignatureVerificationError => e
            # Invalid signature
            puts "Error verifying webhook signature: #{e.message}"
            status 400
            p e
            return
        end
  
      # Handle the event
      case event.type
      when 'checkout.session.completed'
            session = event.data.object 
            #@product = Product.find_by("stripe_product_id": session.metadata.product_id)
            #@product.increment!(:sales_count)
          
            session_with_expand = Stripe::Checkout::Session.retrieve({ id: session.id, expand: ["line_items"]})
            p session_with_expand
            # session_with_expand.line_items.data.each do |line_item|
            #   product = Product.find_by(stripe_product_id: line_item.price.product)
            #   product.increment!(:sales_count)
            # end
            @product = Product.find_by("stripe_product_id": session.metadata.product_id)
            p session.metadata.product_id
            @product.increment!(:sales_count)
          
      end
          
          puts 'PaymentIntent was successful!'
      # when 'payment_method.attached'
      #   payment_method = event.data.object # contains a Stripe::PaymentMethod
      #   puts 'PaymentMethod was attached to a Customer!'
      # # ... handle other event types
      # else
      #   puts "Unhandled event type: #{event.type}"
      # end
    
        status 200
        render json: { message: 'success' }
      
    end
end

