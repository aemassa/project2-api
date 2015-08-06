class EventSerializer < ActiveModel::Serializer
  attributes :date, :time, :location, :address_line1, :city, :state, :zip

  has_many :rsvps
end
