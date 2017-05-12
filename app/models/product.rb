class Product < ApplicationRecord
  
  def self.search(search_term)
    Product.where("name LIKE ? OR description LIKE ?","%#{search_term}%","%#{search_term}%")
  end
  
  def self.searchAdmin(admin_search, carousel_image)
    products = Product.all
    
    if !admin_search.strip.empty?
      products = products.where("name LIKE ? OR description LIKE ?", "%#{admin_search}%", "%#{admin_search}%")
    end
    
    if carousel_image == "true"
      products = products.where("carousel_image IS NOT NULL", [])
    else
      products = products.where("carousel_image IS NULL", [])
    end
    
    products
  end
    
end


