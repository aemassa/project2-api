class RsvpSerializer < ActiveModel::Serializer
  attributes :id, :confirmed, :item, :profile_of_rsvp, :belongs_to_current_user

  def profile_of_rsvp
    object.user.profile
  end

  def belongs_to_current_user
    scope == object.user
  end

end
