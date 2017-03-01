json.book do 
	json.status = @status
	json.name @book.title
	json.price @book.price
	json.email @book.user.email
	json.phone @book.user.contacts
	json.desc @book.description
	json.thumb @book.pictures[0].image.url(:thumb)
end 
