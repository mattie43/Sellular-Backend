class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :user_products]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def user_products
    render json: @user.products
  end

  def show
    conversations = Conversation.where("seller = #{@user.id} or buyer = #{@user.id}")
    mapped_convos = conversations.map { |convo|
      product = Product.find(convo.product)
      {
        conversation: convo,
        buyer: User.find(convo.buyer),
        product: {
          id: product.id,
          name: product.name,
          price: product.price,
          description: product.description,
          img_url: product.get_image_url
        },          
        seller: User.find(convo.seller),
      }
    }
    render json: mapped_convos
  end

  # POST /users
  def create
    @user = User.new(user_params)

    exists = User.find_by(email: @user.email)

    if exists
      render json: exists, status: :ok
    elsif @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password, :bio, :uid)
    end
end
