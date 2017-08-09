require 'rails_helper'

describe ProductsController, type: :controller do 

  before do	
	@user = FactoryGirl.create(:user)
	@admin = FactoryGirl.create(:admin)
	@product1 = FactoryGirl.create(:product)
	@product2 = FactoryGirl.create(:product)
	@product3 = FactoryGirl.create(:product, name: "Miao", description: "Woof")
  end

  ##### GET index
  describe 'GET #index' do

    context 'when GET index and search_term exists' do
    	it 'display the products that match the search term' do
    		get :index, params: {q: 'Miao'}
    		expect(assigns(:products)).to match_array([@product3])
    		expect(response).to render_template('index')
		end
	end

	context 'when GET index and admin_search exists' do
		before do
			sign_in @admin
		end
    	it 'display the products that match the search term' do
    		get :index, params: {aq: 'Miao', has_carousel_picture: true}
    		expect(assigns(:products)).to match_array([@product3])
    		expect(response).to render_template('index')
		end
	end

	context 'when GET index and no search_term exists' do
		it 'display all the products' do
			get :index
			expect(assigns(:products)).to match_array([@product1, @product2, @product3])
		end

		it 'show the index template' do
			get :index
			expect(response).to render_template('index')
		end
	end
  end
  
  ##### GET show
  describe 'GET #show' do

  	context 'when GET show is requested' do
  		it 'render the show template' do
  			get :show, params: { id: @product1 }
  			expect(response.status). to eq 200
  			expect(response).to render_template('show')
  		end
  	end
  end

  ##### GET new
  describe 'GET #new' do
  	context 'when GET new is requested and the user is not signed in' do
  		it 'redirect to login page' do
			get :new, params: { id: @user.id }
			expect(response).to redirect_to(new_user_session_path)
		end
  	end

  	context 'when GET new is requested and the user is not admin' do
  		before do
			sign_in @user
		end
  		it 'redirect the user to the home page' do
  			get :edit, params: { id: @product1.id }
			expect(response.status).to eq 302
  		end
  	end

  	context 'when GET new is requested and the user is admin' do
  		before do
  			sign_in @admin
  		end
  		it 'create a new product' do
  			get :new
  			expect(assigns(:product)).to be_a_new(Product)
  		end
  		it 'display template for new product' do
  			get :new
  			expect(response).to render_template('new')
  		end
  	end
  end

  ##### GET edit
  describe 'GET #edit' do

	
	context 'when a non admin wants to edit a product' do
		before do
			sign_in @user
		end
		it 'redirect the user to the home page' do
			get :edit, params: { id: @product1.id }
			expect(response.status).to eq 302
		end
	end

	context 'when an admin wants to edit a product' do
		before do
			sign_in @admin
		end
		it 'send admin to the edit page' do
			get :edit, params: { id: @product1.id }
			expect(response.status).to eq 200
		end
	end
  end

  ##### GET create
  describe 'POST create'

  	context 'when a new + complete product is created' do
  		before do
  			sign_in @admin
  		end
  		it 'saves the product to the database' do
  			before = Product.all.length
  			post :create, params: { product: {name: "Miao", description: "miao2", image_url: "url", carousel_image: "url2", color: "black", price: "1.99" }}

  			after = Product.all.length
  			expect(response.status).to eq 302
  			expect(response).to redirect_to("http://test.host/products")
  			expect(after).to eq (before + 1)
  		end
  	end

  	context 'when a new + incomplete product is created' do
  		before do
  			sign_in @admin
  		end
  		it 'returns not valid' do
  			before = Product.all.length
  			post :create, params: { product: {name: "Miao", description: "miao2", image_url: "url", carousel_image: "url2", color: "black" }}

  			after = Product.all.length
  			expect(response.status).to eq 200
  			expect(response).to render_template('new')
  			expect(after).to eq before
  		end
  	end


  ##### PATCH update

  describe 'PATCH update'

  	context 'when a complete product is updated' do
  		before do
  			sign_in @admin
  		end
  		it 'saves the product to the database' do
  			before = Product.all.length
  			patch :update, params: { id: @product1.id, product: {name: "newname"} }

  			after = Product.all.length
  			expect(response.status).to eq 302
  			expect(response).to redirect_to("http://test.host/products")
  			expect(after).to eq before
  			expect(Product.where("id = ?", @product1.id).first.name).to eq "newname"
  		end
  	end

    context 'when a complete product is updated with a non valid value' do
      before do
        sign_in @admin
      end
      it 'returns not valid' do
        before = Product.all.length
        patch :update, params: { id: @product1.id, product: {name: ""} }

        after = Product.all.length
        expect(response.status).to eq 200
        expect(after).to eq before
        expect(Product.where("id = ?", @product1.id).first.name).to eq @product1.name
      end
    end

  	context 'when a nonexistent product is updated' do
  		before do
  			sign_in @admin
  		end
  		it 'returns not valid' do
  			before = Product.all.length
  			expect{patch :update, params: { id: 123456, product: {name: "newname"} }}.to raise_error(ActiveRecord::RecordNotFound)

  			after = Product.all.length
  			expect(after).to eq before
  		end
  	end

  ##### DELETE destroy
  describe 'DELETE #destroy' do


	context "when an admin wants to delete a product" do
		before do
			sign_in @admin
		end
		it 'destroy' do
			delete :destroy, params: { id: @product1.id }
			expect(response.status).to eq 302
		end
	end
  end

end