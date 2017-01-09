module AccommodationsHelper
  #todo bad code and these should be in the user helper
  def get_accom(transaction)
    return Accommodation.find(transaction.accomodation_id) unless transaction.nil?
  end

  def get_user(transaction)
    return User.find(transaction.user_id)
  end

  def make_nice_badges(room_type)
    if room_type == 'Sharing'
      return 'c-green'
    elsif room_type == 'Cottage'
      return 'c-blue'
    elsif room_type == 'Single'
      return 'c-red'
    elsif room_type == 'Apartment'
      return 'my-btn'
    end

  end
end
