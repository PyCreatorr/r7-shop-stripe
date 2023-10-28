class Product < ApplicationRecord

    validates :name, :price, presence: true
    
    # to call just the product, without name
    def to_s
        name
    end
end
