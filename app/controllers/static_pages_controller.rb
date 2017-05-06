class StaticPagesController < ApplicationController
  def index
  end
  
  def landing_page
    @products = Product.last(5)
    render layout: "landing"
  end
  
  #def landing_page
    #@featured_product = Product.first
  #end
  
end


