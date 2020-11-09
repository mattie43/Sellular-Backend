class Product < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_base64_attached :product_image

  belongs_to :user

  def get_image_url
    url_for(self.product_image)
  end

  def post_date
    current_day = Date.today
    created_day = self.created_at.to_date
    (current_day - created_day.to_date).to_i
  end

end
