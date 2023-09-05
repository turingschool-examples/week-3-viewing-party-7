class User <ApplicationRecord 
  validates_presence_of :email, :name 
  validates_uniqueness_of :email
  validates_presence_of :password
  validates_presence_of :password_confirmation

  has_secure_password
end
