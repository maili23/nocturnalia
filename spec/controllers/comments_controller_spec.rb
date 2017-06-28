require 'rails_helper'

describe CommentsController, type: :controller do 
	user = FactoryGirl.create(:user)
	let(:product) { Product.create!(name: "awesome cup", description: "great", image_url: "cup6-169", carousel_image: "cup6-11", color: "gray", price: "34" ) }

	context 'when a user writes a comment' do
		before do
			sign_in user
			product.save
		end
		it 'saves the comment on the product page' do
			post :create, params: { product_id: product.id, comment: { body: "Blabla", rating: 3 } }
			expect(response.status).to eq 302
			comment_from_db = Comment.last()
			expect(comment_from_db.product.id).to eq product.id
		end
	end
	
end


