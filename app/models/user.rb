class User < ActiveRecord::Base
  has_many :completed_surveys
  has_many :surveys
  
  validates_uniqueness_of :email

  def self.authenticate(email, password)
    BCrypt::Password.new(User.where(email: email).first.password_hash) == password
  end

end
