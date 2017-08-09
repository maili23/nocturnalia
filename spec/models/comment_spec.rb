require 'rails_helper'

describe Comment do
  context "when the comment has no rating" do
    product = FactoryGirl.build(:product)
    user = FactoryGirl.build(:user)
    before do
      product.comments.new(user: user, body: "Awful cup!", rating: nil)
    end
    it "is not accepted" do
      expect(product.comments.first).not_to be_valid
    end
  end    

  context "when the comment has a negative rating" do
    product = FactoryGirl.build(:product)
    user = FactoryGirl.build(:user)
    before do
      product.comments.new(user: user, body: "Awful cup!", rating: -10)
    end
    it "is not accepted" do
      expect(product.comments.first).not_to be_valid
    end
  end  
  
  context "when the comment has a very high rating" do
    product = FactoryGirl.build(:product)
    user = FactoryGirl.build(:user)
    before do
      product.comments.new(user: user, body: "Awful cup!", rating: 10)
    end
    it "is not accepted" do
      expect(product.comments.first).not_to be_valid
    end
  end    
  
  context "when the comment has no body" do
    product = FactoryGirl.build(:product)
    user = FactoryGirl.build(:user)
    before do
      product.comments.new(user: user, body: "", rating: 1)
    end
    it "is not accepted" do
      expect(product.comments.first).not_to be_valid
    end
  end  

  context "when the comment has no user" do
    product = FactoryGirl.build(:product)
    user = FactoryGirl.build(:user)
    before do
      product.comments.new(body: "Awful cup!", rating: 1)
    end
    it "is not accepted" do
      expect(product.comments.first).not_to be_valid
    end
  end  

  context "when the comment has no product" do
    it "is not accepted" do
      user = FactoryGirl.build(:user)
      comment = Comment.new(user: user, body: "Awful cup!", rating: 1)
      expect(comment).not_to be_valid
    end
  end  

end
