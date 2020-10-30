class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :bio, :uid, :products

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
