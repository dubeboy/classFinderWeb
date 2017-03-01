module ApplicationHelper
  def active (controller)
    if params[:controller] == controller
      return 'active-header'
    end
  end

  def locations_array
    ['Auckland Park',  'Braamfontein', 'Doornfontein', 'Soweto']
  end

  def if_auckland_park_array
    ['Auckland Park, Brixton', 'Auckland Park, Westedene', 'Auckland Park, Hursthil', 'Auckland Park, Mellville', 'Auckland Park, Vrededorp']
  end

  def institutions_array
    ['UJ', 'Wits']
  end

  def clean_number(n)
      number = n.scan(/\d+/).join
      number[0] == '0' ? number = '+27' + number[1..10] : number
      return number
  end
end
