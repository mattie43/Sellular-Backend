class Product < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_base64_attached :product_image

  belongs_to :user

  def get_image_url
    url_for(self.product_image)
  end

end
