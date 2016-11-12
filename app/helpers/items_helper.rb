module ItemsHelper
  def image_slider_helper(counter)
    if counter == 0
     'active item'
    else
      'item'
    end
  end


  # todo i am not sure if this is efficient enough
  def fit_string(description)
       description[0..60].capitalize
  end
end
