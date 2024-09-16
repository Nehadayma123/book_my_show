
class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings   
  validates :email, presence: true
  validates :email, uniqueness: true       
  enum role: { user: 0, admin: 1 }
  after_initialize :set_default_role, if: :new_record?
       
  def set_default_role
    self.role ||= :user
  end
           
end
