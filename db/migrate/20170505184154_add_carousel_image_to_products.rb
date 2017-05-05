class AddCarouselImageToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :carousel_image, :string
  end
end
