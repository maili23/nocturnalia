require 'rails_helper'

describe UsersController, type: :controller do
	let(:user1) { User.create!(first_name: "User", last_name: "One", email: "myemail1@mydomain.com", password: "lemmetestthis") }
	let(:user2) { User.create!(first_name: "User", last_name: "Two", email: "myemail2@mydomain.com", password: "lemmetestthis") }
	
	describe 'GET #show' do
		context 'when a user is logged in' do
			before do
				sign_in user1
			end
			it 'loads correct user details' do
				get :show, params: { id: user1.id }
				expect(response).to be_ok
				expect(assigns(:user)).to eq user1
			end
		end

		context 'when a user is not logged in' do
			it 'redirects to login page' do
				get :show, params: { id: user1.id }
				expect(response).to redirect_to(new_user_session_path)
			end
		end	

		context 'when a user tries to access another users page' do
			before do
				sign_in user2
			end
			it 'redirects the user to the homepage' do
				get :show, params: { id: user1.id }
				expect(response.status).to eq 302
				expect(response).to redirect_to(static_pages_index_path)
			end
		end

	end

end