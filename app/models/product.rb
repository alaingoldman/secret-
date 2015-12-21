class Product < ActiveRecord::Base
   has_attached_file :image, styles: { medium: "500x500>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
   validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  
   validates :image, attachment_presence: true
   validates :title, presence: true
   validates :category, presence: true
   validates :description, presence: true
   validates :price, presence: true
end
