class CheckoutController < ApplicationController
    def create
        # binding.break

        if (current_user.stripe_customer_id.present?)
          customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
        end 

        #product = Product.find(params[:id])


        @session = Stripe::Checkout::Session.create({
            customer: current_user.stripe_customer_id,
            payment_method_types: ['card'],

            # line_items: [{
            #   @cart.each do |product| {               
            #     price: product.stripe_price_id.to_s,
            #     quantity: 1 }
              
            #   }],
            line_items: @cart.map { |item| item.to_builder.attributes! },
            mode: 'payment',
            success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
            cancel_url: cancel_url
          });

        # respond_to do |format|
        #     # format.js
        #     format.turbo_stream { render "checkout/create"
        #         #locals: {stock_item: stock, allowed: true, flash_notice: "#{stock.name} was successfully added to your data!" }
        #     }
        # end
        
        #redirect_to @session.url, allow_other_host: true

        render turbo_stream: turbo_stream.append(
          :reload,
          partial: 'shared/reload_script',
          locals: { redirect_url: @session.url })
    end

    def success
      if params[:session_id].present?
        # session[:cart] = [] or we just delete cart.
        session.delete(:cart)
        @session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ['line_items']})
        @session_with_expand.line_items.data.each do |line_item| 
          product = Product.find_by("stripe_product_id": line_item.price.product)
        # product.increment!(:sales_count) if product.present? # increment saves the product in db also       
        end
      else
        # flash.now[:danger] = "No info to display!"
        flash[:danger] = "No info to display!"
        redirect_to cancel_url
      end
      # redirect_to products_path
    end

    def cancel
    end
end