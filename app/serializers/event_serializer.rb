class EventSerializer < ActiveModel::Serializer
  attributes :id, :description, :date, :time, :location, :created_by
  def created_by
    object.created_by.profile if object.created_by
  end

  has_many :rsvps
end
