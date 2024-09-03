class Theatre < ApplicationRecord
    has_many :shows, dependent: :destroy
    has_many :movies, through: :shows
    validates :name, presence: true
    validates :location, presence: true
end
