require 'rails_helper'

describe UsersController, type: :controller do
	
	describe 'GET #show' do
		context 'when a user is logged in' do
			it 'loads correct user details' do
				user1 = FactoryGirl.create(:user)
				sign_in user1

				get :show, params: { id: user1.id }
				expect(response).to be_ok
				expect(assigns(:user)).to eq user1
			end
		end

		context 'when a user is not logged in' do
			it 'redirects to login page' do
				user1 = FactoryGirl.create(:user)
				get :show, params: { id: user1.id }
				expect(response).to redirect_to(new_user_session_path)
			end
		end	

		context 'when a user tries to access another users page' do
			before do
				user2 = FactoryGirl.create(:user)
				sign_in user2
			end
			it 'redirects the user to the homepage' do
				user1 = FactoryGirl.create(:user)
				get :show, params: { id: user1.id }
				expect(response.status).to eq 302
				expect(response).to redirect_to(static_pages_index_path)
			end
		end

	end

end
