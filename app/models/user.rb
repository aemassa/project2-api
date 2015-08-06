class User < ActiveRecord::Base
  has_one :profile, autosave: true
  has_many :rsvps
  has_many :events, through: :rsvps
  has_many :events_created, inverse_of: :created_by, class_name: Event
  has_secure_password
  # adds both pw and pw confirmation virtual attributes, as well as an authenticate method. see ActiveModel::Secure Password documentation.

  before_create :set_token

  validates :email, uniqueness: true

  def self.login(email, password)
    user = find_by email: email
    user.login password if user
  end

  def login (password)
    authenticate(password) && set_token && save! && token
  end

  private

  def set_token
    self.token = SecureRandom.hex
  end
end
