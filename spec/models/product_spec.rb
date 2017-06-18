require 'rails_helper'

describe Product do
  context "when the product has comments" do
    let(:product) { Product.create!(name: "awesome cup", description: "great", image_url: "cup6-169", carousel_image: "cup6-11", color: "gray", price: "34" ) }
    let(:user) { User.create!(email: "myemail@mydomain.com", password: "lemmetestthis") }
    before do
      product.comments.create!(rating: 1, user: user, body: "Awful cup!")
      product.comments.create!(rating: 3, user: user, body: "Ok cup!")
      product.comments.create!(rating: 5, user: user, body: "Great cup!")
    end
    it "returns the average rating of all comments" do
      expect(product.average_rating).to eq 3
    end
  end
  
  context "when the product has no name" do
    let(:product) { Product.new(description: "Nice cup") }
    
    it "should not be valid" do
      expect(Product.new(description: "Nice cup")).not_to be_valid
    end
  end
    

end