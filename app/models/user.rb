class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  validates :password, length: {minimum: 6}
  before_save :email_downcase #before_save { self.email = email.downcase } also works
  has_secure_password   #CREATES VIRTUAL ATTRIBUTES (PASSWORD AND PASSWORD_CONFIRMATION)
  before_create :create_remember_token

  def email_downcase
    self.email = self.email.downcase
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Micropost.where('user_id = ?', id) #same as self.microposts or just microsposts
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end