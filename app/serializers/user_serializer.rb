class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :bio, :products, :join_date

  def join_date
    object.created_at.strftime("%m-%d-%Y")
  end

  def products
    # add three categories together
    object.products.map { |product| 
      {
        id: product.id, 
        name: product.name, 
        price: product.price, 
        description: product.description, 
        img_url: product.get_image_url
      }
    }
  end

end
