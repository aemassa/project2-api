class Event < ActiveRecord::Base
  has_many :items
  has_many :people, through: :items
end
