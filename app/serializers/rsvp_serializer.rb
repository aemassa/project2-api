class RsvpSerializer < ActiveModel::Serializer
  attributes :id, :confirmed, :item, :profile_of_rsvp

  def profile_of_rsvp
    object.user.profile
  end

end
