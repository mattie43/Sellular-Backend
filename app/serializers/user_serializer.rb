class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :bio, :uid
end
