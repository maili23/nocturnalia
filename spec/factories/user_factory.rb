FactoryGirl.define do
 	sequence :email do |n|
   		"myemail#{n}@domain#{n}.com"
  	end
  	sequence :first_name do |n|
   		"First#{n}"
  	end
  	sequence :last_name do |n|
   		"Last#{n}"
  	end
  	sequence :password do |n|
   		"password#{n}"
  	end


	factory :user do
		email 
		password
		first_name
		last_name
		admin false
	end

	factory :admin, class: User do
		email 
		password
		first_name
		last_name
		admin true
	end

end