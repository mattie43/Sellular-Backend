class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :update, :destroy]

  # GET /conversations
  def index
    @conversations = Conversation.all

    render json: @conversations
  end

  # GET /conversations/1
  def show
    render json: @conversation.messages
  end

  # POST /conversations
  def create
    conversation = Conversation.find_or_create_by(seller: params[:seller], buyer: params[:buyer], product: params[:product])

    product = Product.find(conversation.product)
    buyer = User.find(conversation.buyer)
    seller = User.find(conversation.seller)
    return_convo = {
      conversation: conversation,
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

    render json: return_convo
  end

  # PATCH/PUT /conversations/1
  def update
    if @conversation.update(conversation_params)
      render json: @conversation
    else
      render json: @conversation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /conversations/1
  def destroy
    @conversation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def conversation_params
      params.require(:conversation).permit(:seller, :buyer, :product)
    end
end
