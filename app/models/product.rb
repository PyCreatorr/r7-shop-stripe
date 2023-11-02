class Product < ApplicationRecord

    validates :name, :price, :currency, presence: true
    
    # to call just the product, without name
    def to_s
        name
    end

    def to_builder
      Jbuilder.new do |product|        
        product.price stripe_price_id        
        product.quantity 1
      end
    end


    after_create do
        product = Stripe::Product.create(name: name)

        price = Stripe::Price.create({
            unit_amount: self.price,
            currency: currency,
            # recurring: {interval: 'month'},
            product: product.id,
          })
        
        update({stripe_product_id: product.id, stripe_price_id: price.id })
    end

    after_update :create_and_assign_new_stripe_price, if: :saved_change_to_price?
    after_update :create_and_assign_new_stripe_price, if: :saved_change_to_currency?
    
    def create_and_assign_new_stripe_price
      price = Stripe::Price.create({ 
        unit_amount: self.price,  
        currency: self.currency,    
        product: self.stripe_product_id
      })      
      update({ stripe_price_id: price.id })      
    end


end
