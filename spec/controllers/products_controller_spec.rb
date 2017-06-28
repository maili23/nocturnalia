require 'rails_helper'

describe ProductsController, type: :controller do 
	user = FactoryGirl.create(:user)
	admin = FactoryGirl.create(:admin)
	let(:product) { Product.create!(name: "awesome cup", description: "great", image_url: "cup6-169", carousel_image: "cup6-11", color: "gray", price: "34" ) }

	context 'when a non admin wants to edit a product' do
		before do
			sign_in user
		end
		it 'redirects the user to the home page' do
			get :edit, params: { id: product.id }
			expect(response.status).to eq 302
			expect(response).to redirect_to(static_pages_index_path)
		end
	end

	context 'when an admin wants to edit a product' do
		before do
			sign_in admin
		end
		it 'sends admin to the edit page' do
			get :edit, params: { id: product.id }
			expect(response).to be_ok
		end
	end

end