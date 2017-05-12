class StaticPagesController < ApplicationController
  def index
  end
  
  def landing_page
    @products = Product.last(3)
    render layout: "landing"
  end
  
  #def landing_page
    #@featured_product = Product.first
  #end
  
  def thank_you
  @name = params[:name]
  @email = params[:email]
  @message = params[:message]
  ActionMailer::Base.mail(:from => @email,
      :to => 'dposnanski@ymail.com',
      :subject => "A new contact form message from #{@name}",
      :body => @message).deliver_now
  end
  
end


