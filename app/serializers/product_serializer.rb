class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :description, :user, :post_date, :img_url, :categories

  def categories
    [object.category_one, object.category_two, object.category_three]
  end

  def post_date
    byebug
    current_day = Date.today
    created_day = object.created_at.to_date
    (current_day - created_day.to_date).to_i
  end

  def img_url
    object.get_image_url
  end

  # def user
  #   # ActiveModelSerializers::SerializableResource.new(object.user,  each_serializer: UserSerializer)
  #   object.user
  # end

end
