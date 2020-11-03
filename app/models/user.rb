class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_base64_attached :profile_image

  has_many :products

  def get_image_url
    url_for(self.profile_image)
  end  
end
