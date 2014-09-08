class User < ActiveRecord::Base
  validates :name, presence: true, length: {maximum: 50}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  validates :password, length: {minimum: 6}
  before_save :email_downcase #before_save { self.email = email.downcase } also works
  has_secure_password   #CREATES VIRTUAL ATTRIBUTES (PASSWORD AND PASSWORD_CONFIRMATION)
  # before_save {email.downcase!}

  def email_downcase
    self.email = self.email.downcase
  end

end
