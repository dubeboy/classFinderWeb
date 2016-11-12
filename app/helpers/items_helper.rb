module ItemsHelper
  def image_slider_helper(counter)
    if counter == 0
     'active item'
    else
      'item'
    end
  end

  def Jfit_string(description, upto)
    j = ' '
    print description.length
    if description.length > upto
      p = description[0..(upto-1)].capitalize + '...'
    else
      (upto - description.length).times { j += " " }
        p = description + j

    end
    return p
  end
  # todo i am not sure if this is efficient enough
  def fit_string(description)
     Jfit_string(description, 90)
  end

  def fit_title(description)
    Jfit_string(description, 12)
  end



end
