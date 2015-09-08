class Pin < ActiveRecord::Base
  validates_presence_of :title, :url, :slug, :text, :category_id
  validates_uniqueness_of :slug

  belongs_to :category

  belongs_to :user

  has_many :pinnings
  has_many :users, through: :pinnings
  # When an image is uploaded to a pin, save a version that’s about 300 x 300 and a version that’s about 60 x 60
  # If no image is found, just use a random adorable bear picture (300×300) as the placeholder. 
  has_attached_file :image, styles: { medium: "300x300>", small: "150x150>", thumb: "60x60>" }, default_url: "http://placebear.com/300/300"  
  # Prohibits any file from being uploaded whose content type is not one listed in the array.
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end