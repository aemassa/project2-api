class EventSerializer < ActiveModel::Serializer
  attributes :id, :description, :date, :time, :location, :created_by, :belongs_to_current_user

  def created_by
    object.created_by.profile if object.created_by
  end

  def belongs_to_current_user
    scope == object.created_by
  end

  has_many :rsvps
end
