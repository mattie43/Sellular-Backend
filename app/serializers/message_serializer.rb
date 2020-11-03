class MessageSerializer < ActiveModel::Serializer
  attributes :id, :message, :user_id, :conversation_id
end
