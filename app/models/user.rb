class User < ActiveRecord::Base
  has_secure_password
  # adds both pw and pw confirmation virtual attributes, as well as an authenticate method. see ActiveModel::Secure Password documentation.

  before_create :set_token

  validates :email, uniqueness: true

  def self.login(email, password)
    user = find_by email: email
    user.login password if user
  end

  def login
    authenticate(password) && set_token && save! && token
  end

  private

  def set_token
    self.token = SecureRandom.hex
  end
end
