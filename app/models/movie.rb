class Movie < ApplicationRecord   
   has_many :shows, dependent: :destroy
   has_many :theatres, through: :shows
   validates :title, presence: true
   validates :title, length: { maximum: 50}
   validates :description, presence: true
   validates :description, length: { maximum: 300}
end
