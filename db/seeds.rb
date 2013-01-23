# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Category.delete_all
Video.delete_all

categories = ['comedy', 'action', 'suspence', 'family', 'sci-fi']
categories.each do |category| 
	Category.create(title:category)
end


for video in 1..5 do
Video.create(name:"Monk",
	     description:"Former police detective Adrian Monk (Tony Shalhoub), whose photographic memory and amazing ability to piece together tiny clues made him a local legend, has suffered from intensified obsessive-compulsive disorder and a variety of phobias since the unsolved murder of his wife, Trudy, in 1997. Now on psychiatric leave from the San Francisco Police Department and working as a freelance detective/consultant on difficult cases, Monk hopes to convince his former boss, Captain Leland Stottlemeyer ",
	small_cvr_url:"monk.jpg",
	lrg_cvr_url: "monk_large.jpg",
		 category_id: 1 )	
end
