module AccommodationsHelper
  #todo bad code and these should be in the user helper
  def get_accom(transaction)
    unless transaction.nil?
      if Accommodation.exists?(id: transaction.accomodation_id)
        return Accommodation.find(transaction.accomodation_id)
      end
    end
  end

  def get_user(transaction)
    return User.find(transaction.user_id)
  end

  def get_runner(transaction)
      return User.find(transaction.runner_id)
  end

  def get_book(t)
    return Book.find(t.book_id)
  end
  
  def get_seller(t)
    User.find(t.user_id)
  end
  def get_buyer(t)
    User.find(t.buyer_id)
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
