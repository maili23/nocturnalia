class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    @comment.user = current_user
    @user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @product, notice: 'Se han agregado tus comentarios exitosamente.' }
        format.json { render :show, status: :created, location: @product }
        format.js
      else
        format.html { redirect_to @product, alert: 'No se han podido agregar tus comentarios.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

   def show
    @comments = @product.comments.order(created_at: :asc)
    @comments = @product.comments.paginate(:page => params[:page], :per_page => 2)
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    product = @comment.product
    @comment.user = current_user
    @comment.destroy
    redirect_to product
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:user_id, :body, :rating)
    end
  
end
