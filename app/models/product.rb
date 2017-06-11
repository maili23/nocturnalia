class Product < ApplicationRecord
  has_many :orders
  has_many :comments
  
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
  
  def highest_rating_comment
    comments.rating_desc.first
  end
  
  def lowest_rating_comment
    comments.rating_asc.first
  end
  
  def average_rating
    comments.average(:rating).to_f
  end
    
end


