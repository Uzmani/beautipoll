class User < ActiveRecord::Base
  has_many :completed_surveys
  has_many :surveys
  
  validates_uniqueness_of :email
  validates :password , length: {minimum: 6 }

  include BCrypt

  def password=(password)
    self.password_hash = Password.create(password)
  end 

  def password
    @password ||= Password.new(password_hash)
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    user ? (user.password == password) : false
  end

end
