class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :seller, :buyer, :product
end
