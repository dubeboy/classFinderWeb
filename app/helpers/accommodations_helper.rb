module AccommodationsHelper
  #todo bad code and these should be in the user helper
  def get_accom(transaction)
    return Accommodation.find(transaction.accomodation_id) unless transaction.nil?
  end

  def get_user(transaction)
    return User.find(transaction.user_id)
  end
end
