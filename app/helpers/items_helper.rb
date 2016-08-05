module ItemsHelper
  def image_slider_helper(counter)
    if counter == 0
     'active item'
    else
      'item'
    end
  end
end
