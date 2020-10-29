class Product < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :productImage

  belongs_to :user

  def get_image_url
    url_for(self.image)
  end
end
