class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :user_products, :convos]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def user_products
    render json: @user.products
  end

  def convos
    conversations = Conversation.where("seller = #{@user.id} or buyer = #{@user.id}")
    mapped_convos = conversations.map { |convo|
      product = Product.find(convo.product)
      buyer = User.find(convo.buyer)
      seller = User.find(convo.seller)
      {
        conversation: convo,
        buyer: {
          id: buyer.id,
          username: buyer.username,
          img_url: buyer.get_image_url
        },
        product: {
          id: product.id,
          name: product.name,
          price: product.price,
          description: product.description,
          img_url: product.get_image_url
        },          
        seller: {
          id: seller.id,
          username: seller.username,
          img_url: seller.get_image_url
        },
      }
    }
    render json: mapped_convos
  end

  def login
    existingUser = User.find_by(username: params[:user][:username])
    if existingUser && existingUser.password == params[:user][:password]
      render json: existingUser
    elsif existingUser
      render json: {password: 'is incorrect'}
    else
      render json: {user: 'not found'}
    end
  end

  def signup
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if params[:image_64]
      image64 = "data:image/jpg;base64,#{params[:image_64]}"
      @user.profile_image.attach(data: image64)
      render json: @user
    elsif @user.update(user_params)
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
      params.require(:user).permit(:email, :username, :password, :bio)
    end
end
