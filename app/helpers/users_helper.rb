module UsersHelper


  #attrthe image object
  def check_if_nil(attr, img, clazz)
    if attr # todo ???
      image_tag attr, class: clazz
    else
      image_tag img, class: clazz
    end
  end
end
