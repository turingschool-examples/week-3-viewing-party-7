class User <ApplicationRecord 
  validates_presence_of :email, :name 
  validates_uniqueness_of :email
  validates_presence_of :password

  has_secure_password
  has_many :viewing_parties
end 