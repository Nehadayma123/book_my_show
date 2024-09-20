class Movie < ApplicationRecord   
   has_many :shows, dependent: :destroy
   has_many :theatres, through: :shows
   has_one_attached :image
   validates :title, presence: true, uniqueness: true
   validates :title, length: { maximum: 50}
   validates :description, presence: true
   validates :description, length: { maximum: 300}
   validates :language, presence: true
end
