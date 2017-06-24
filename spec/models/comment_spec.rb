require 'rails_helper'

describe Comment do
  context "when the comment has no rating" do
    let(:product) { Product.new(name: "awesome cup", description: "great", image_url: "cup6-169", carousel_image: "cup6-11", color: "gray", price: "34" ) }
    let(:user) { User.new(email: "myemail@mydomain.com", password: "lemmetestthis") }
    before do
      product.comments.new(user: user, body: "Awful cup!", rating: nil)
    end
    it "is not accepted" do
      expect(product.comments.first).not_to be_valid
    end
  end    
  
  context "when the comment has a negative rating" do
    let(:product) { Product.new(name: "awesome cup", description: "great", image_url: "cup6-169", carousel_image: "cup6-11", color: "gray", price: "34" ) }
    let(:user) { User.new(email: "myemail@mydomain.com", password: "lemmetestthis") }
    before do
      product.comments.new(user: user, body: "Awful cup!", rating: -10)
    end
    it "is not accepted" do
      expect(product.comments.first).not_to be_valid
    end
  end  
  
  context "when the comment has a very high rating" do
    let(:product) { Product.new(name: "awesome cup", description: "great", image_url: "cup6-169", carousel_image: "cup6-11", color: "gray", price: "34" ) }
    let(:user) { User.new(email: "myemail@mydomain.com", password: "lemmetestthis") }
    before do
      product.comments.new(user: user, body: "Awful cup!", rating: 10)
    end
    it "is not accepted" do
      expect(product.comments.first).not_to be_valid
    end
  end    

end