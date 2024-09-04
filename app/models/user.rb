class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def admin?
    admin
  end
  has_many :bookings
     
   validates :email, presence: true
   validates :email, uniqueness: true
            
end
