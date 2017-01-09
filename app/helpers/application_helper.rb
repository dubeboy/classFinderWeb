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
end
