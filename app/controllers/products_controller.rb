class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all
    excludeSold = @products.filter{|product| product.sold == false}
    render json: excludeSold
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.create(product_params)
    
    image64 = "data:image/jpg;base64,#{params[:image_64]}"
    @product.product_image.attach(data: image64)

    render json: @product
  end

  def rating_update
    seller = User.find(params[:seller])
    product = Product.find(params[:id])
    rating = params[:rating]

    product.rated = true
    product.save

    seller.rating_count = seller.rating_count + 1
    seller.rating = ((seller.rating + rating) / seller.rating_count).round()
    seller.save

    render json: product
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :price, :description, :sold, :category_one, :category_two, :category_three, :user_id)
    end

end
