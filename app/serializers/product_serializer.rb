class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :description, :image_64, :user, :post_date

  def post_date    
    current_day = Date.today
    created_day = object.created_at.to_date
    (current_day - created_day.to_date).to_i
  end

  def user
    ActiveModelSerializers::SerializableResource.new(object.user,  each_serializer: UserSerializer)
  end

end
