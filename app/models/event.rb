class Event < ActiveRecord::Base
  belongs_to :created_by, inverse_of: :events, class_name: User, :foreign_key => 'user_id'

  has_many :rsvps
  has_many :users, through: :rsvps
end
