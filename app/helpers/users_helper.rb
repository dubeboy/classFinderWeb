module UsersHelper


  #attrthe image object
  def check_if_nil(attr, img, clazz)
    if attr # todo ???
      image_tag attr, class: clazz
    else
      image_tag img, class: clazz
    end
  end


#crapy code can be greatly simplifies
  def gen_active(pip, k)
      num = pip.to_i
      n = k.to_i

      if num == 0 and n == num
        return 'active'
      elsif num == 1 and n == num
        return 'active'
      elsif num == 2 and n == num
        return 'active'
      elsif num == 3 and n == num
        return'active'
      elsif num == 4 and n == num
        return 'active'
      else
        return nil
      end
  end


  def explain_host(pip, k)
    if gen_active(pip, 1)
      return 'This is all your accommodations'
    elsif gen_active(pip, 1)
      return 'These are the rooms that students have booked for viewing'
    elsif gen_active(pip, 2)
      return 'These are student who want to review rooms'
    elsif gen_active(pip, 3)
      return 'These are all the students who say they have paid, please confirm by checking against their reference number and then click paid'
    elsif gen_active(pip, 4)
      return 'These a rooms that the student has fully paid'
    else
      ""
    end
  end


  def explain_runner(pip)
    if gen_active(pip, 1)
      return 'Students who want to view place'
    elsif gen_active(pip, 2)
      return 'Students who have paid for the rooms'
    elsif gen_active(pip, 3)
      return 'These are student who want to review rooms'
    end
  end
end
