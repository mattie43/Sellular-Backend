class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  validates :username, uniqueness: true
  validates :email, uniqueness: true, email: true
  validates :username, :password, presence: true
  has_one_base64_attached :profile_image
  has_many :products

  def get_image_url
    if self.profile_image.attached?
      url_for(self.profile_image)
    else
      rand(1..2) == 1 ? "https://www.w3schools.com/howto/img_avatar2.png" :  "https://www.w3schools.com/howto/img_avatar.png"
    end
  end
end
