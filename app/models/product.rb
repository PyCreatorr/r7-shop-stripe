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
    # after_update :create_and_assign_new_stripe_price, if: :saved_change_to_currency?
    #after_update :update_and_assign_new_name, if: :saved_change_to_name?
    # after_update :update_and_assign_new_name, if: :saved_changes.keys
    
    def create_and_assign_new_stripe_price
      price = Stripe::Price.create({ 
        unit_amount: self.price,  
        currency: self.currency,    
        product: self.stripe_product_id
      })
      #product = Stripe::Product.update( self.stripe_product_id , name: self.name)
      update({ stripe_price_id: price.id})      
    end

    def update_and_assign_new_name
      product = Stripe::Product.update( self.stripe_product_id, name: self.name)  
    end


end
