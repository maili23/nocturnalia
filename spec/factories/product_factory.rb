FactoryGirl.define do
  sequence :name do |n|
		"Wondercat cup #{n}"
	end
	sequence :image_url do |n|
 		"cup#{n}-11.jpg"
	end
  sequence :carousel_image do |n|
    "cup#{n}-169.jpg"
  end

	factory :product do
		name 
		description "The great cup that was made by cool guys in a magical place"
		image_url
		color "black"
		price "15.99"
		carousel_image
	end

end