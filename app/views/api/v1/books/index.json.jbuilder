json.array! @books do |b|
	json.name b.title
	json.price b.price
	json.email b.user.email
	json.phone b.user.contacts
	json.desc b.description
	json.thumb b.pictures[0].image.url(:thumb)
end