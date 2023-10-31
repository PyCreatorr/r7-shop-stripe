class CheckoutController < ApplicationController
    def create
        # binding.break

        if (current_user.stripe_customer_id.present?)
          customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
        end 
        # price_id = price = Stripe::Price.search({ 
        #   query: `product:\'${product.stripe_product_id}\'` 
        #  })
        product = Product.find(params[:id])

        #price = Stripe::Product.retrieve(product.stripe_product_id)

        # copied and edited from https://stripe.com/docs/payments/checkout/migration
        # we eill get the product data from our db from params from views/products/_product.html.erb
        @session = Stripe::Checkout::Session.create({
            customer: current_user.stripe_customer_id,
            payment_method_types: ['card'],
            metadata: {
                # order_id: parsedOrder._id,
                product_id: product.stripe_product_id
            },
            line_items: [{
                # price_data: {
                  price: product.stripe_price_id,
                  # currency: product.price,
                  # unit_amount: product.price,
                  # product_data: {
                  #   name: product.name,
                    # description: 'Comfortable cotton t-shirt',
                    # images: ['https://example.com/t-shirt.png'],
                  # },
                # },
                quantity: 1,
              }],
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
        redirect_to @session.url, allow_other_host: true
    end

    def success
      # session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ['line_items']})
      # session_with_expand.line_items.data.each do |line_item| 
      #   product = Product.find_by("stripe_product_id": line_item.price.product)
      #   product.increment!(:sales_count) if product.present? # increment saves the product in db also       
      # end
      # redirect_to products_path
    end

    def cancel
    end
end