require 'rails_helper'

describe Product do
  
  context "when the product has comments" do
    let(:product) { Product.create!(name: "awesome cup", description: "great", image_url: "cup6-11", carousel_image: "cup6-169", color: "gray", price: "34" ) }
    user = FactoryGirl.build(:user)

    before do
      product.comments.create!(rating: 1, user: user, body: "Awful cup!")
      product.comments.create!(rating: 3, user: user, body: "Ok cup!")
      product.comments.create!(rating: 5, user: user, body: "Great cup!")
    end
    it "returns the average rating of all comments" do      
      expect(product.average_rating).to eq 3
    end
    it "gives the lowest rating comment" do
      expect(product.lowest_rating_comment.rating).to eq 1
    end
    it "gives the highest rating comment" do
      expect(product.highest_rating_comment.rating).to eq 5
    end
  end
  
  context "when the product has no name" do
    product = FactoryGirl.build(:product)
    product.name = ""
    
    it "should not be valid" do
      expect(product).not_to be_valid
    end
  end

  context "when the product has no description" do
    product = FactoryGirl.build(:product)
    product.description = ""

    it "should not be valid" do
      expect(product).not_to be_valid
    end
  end

  context "when the product has no image" do
    product = FactoryGirl.build(:product)
    product.image_url = ""

    it "should not be valid" do
      expect(product).not_to be_valid
    end
  end

  context "when the product has no carousel_image" do
    product = FactoryGirl.build(:product)
    product.carousel_image = ""

    it "should not be valid" do
      expect(product).not_to be_valid
    end
  end

  context "when the product has no color" do
    product = FactoryGirl.build(:product)
    product.color = ""

    it "should not be valid" do
      expect(product).not_to be_valid
    end
  end

  context "when the product has no price" do
    product = FactoryGirl.build(:product)
    product.price = ""

    it "should not be valid" do
      expect(product).not_to be_valid
    end
  end


  context "when the product has no views" do
    product = FactoryGirl.create(:product)

    before do
      $redis.del(product.id)
    end

    it "hits returns 0" do
      expect(product.hits).to eq 0
    end

    it "first view gives 1 hits" do
      expect(product.hit_it).to eq "OK"
      expect(product.hits).to eq 1
    end
  end


end
