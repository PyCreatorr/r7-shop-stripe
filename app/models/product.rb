class Product < ApplicationRecord

    validates :name, :price, :currency, presence: true
    
    # to call just the product, without name
    def to_s
        name
    end

    after_create do
        product = Stripe::Product.create(name: name)

        Stripe::Price.create({
            unit_amount: price,
            currency: currency,
            # recurring: {interval: 'month'},
            product: product.id,
          })
        
        update(stripe_product_id: product.id)
      end
end
