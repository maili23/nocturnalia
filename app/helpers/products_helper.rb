module ProductsHelper
  def cache_key_for_products(params)
    count          = Product.count
    max_updated_at = Product.maximum(:updated_at).try(:utc).try(:to_s, :number)

    q = ""
    if params[:q]
      q = params[:q]
    elsif (params[:aq] && !params[:aq].strip.empty?) || params[:has_carousel_picture]
      q = "#{params[:aq]}-#{params[:has_carousel_picture]}"
    end

    "products/all-#{count}-#{max_updated_at}-#{q}"
  end
end
