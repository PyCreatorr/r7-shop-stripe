class Product < ApplicationRecord

    validates :name, :price, :price_cents, :currency, presence: true
    
    # to call just the product, without name
    def to_s
        name
    end

    monetize :price, as: :price_cents

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
            currency: self.currency,
            # recurring: {interval: 'month'},
            product: product.id,
          })
        
        update({stripe_product_id: product.id, stripe_price_id: price.id })
    end

    #after_update :create_and_assign_new_stripe_price, if: :saved_change_to_price?
    # after_update :create_and_assign_new_stripe_price, if: :saved_change_to_currency?
    #after_update :update_and_assign_new_name, if: :saved_change_to_name?
    # after_update :update_and_assign_new_name, if: :saved_changes.keys

    after_update :create_and_assign_new_stripe_price
    
    def create_and_assign_new_stripe_price

      stripe_old_price = Stripe::Price.retrieve(self.stripe_price_id)
      if stripe_old_price.unit_amount != self.price || stripe_old_price.currency != self.currency      
        price = Stripe::Price.create({ 
          unit_amount: self.price,  
          currency: self.currency,    
          product: self.stripe_product_id
        })
        update({ stripe_price_id: price.id})
      end

      stripe_old_product = Stripe::Product.retrieve(self.stripe_product_id)
      Stripe::Product.update( self.stripe_product_id, name: self.name) if stripe_old_product.name != self.name        
     
      #product = Stripe::Product.update( self.stripe_product_id , name: self.name)
            
    end

    # def update_and_assign_new_name
    #   product = Stripe::Product.update( self.stripe_product_id, name: self.name)  
    # end


end
