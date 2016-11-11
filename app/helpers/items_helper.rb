module ItemsHelper
  def image_slider_helper(counter)
    if counter == 0
     'active item'
    else
      'item'
    end
  end

  def fit_string(description)
       description[0..60]
  end
end
