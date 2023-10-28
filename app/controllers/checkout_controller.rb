class CheckoutController < ApplicationController
    def create
        # binding.break

        product = Product.find(params[:id])
        # copied and edited from https://stripe.com/docs/payments/checkout/migration
        # we eill get the product data from our db from params from views/products/_product.html.erb
        @session = Stripe::Checkout::Session.create({
            payment_method_types: ['card'],
            # line_items: [{
            #     name: product.name,
            #     amount: product.price,
            #     currency: 'usd',
            #     quantity: 1
            # }],
            line_items: [{
                price_data: {
                  currency: 'usd',
                  unit_amount: product.price,
                  product_data: {
                    name: product.name,
                    # description: 'Comfortable cotton t-shirt',
                    # images: ['https://example.com/t-shirt.png'],
                  },
                },
                quantity: 1,
              }],
            mode: 'payment',
            success_url: root_url,
            cancel_url: root_url,
          });
        # respond_to do |format|
        #     # format.js
        #     format.turbo_stream { render "checkout/create"
        #         #locals: {stock_item: stock, allowed: true, flash_notice: "#{stock.name} was successfully added to your data!" }
        #     }
        # end
        redirect_to @session.url, allow_other_host: true
    end
end