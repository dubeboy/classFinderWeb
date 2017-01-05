module ApplicationHelper
def active (controller)
  puts '-----------------------------------999999'
  puts params[:controller]
  puts '-----------------------------------999999'
  if params[:controller] == controller
    return 'active'
  end
end
def locations_array
  ['Auckland Park', 'Braamfontein', 'Doornfontein',  'Soweto']
end
end
