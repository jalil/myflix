# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Category.destroy_all
Video.destroy_all

categories = ['comedy', 'drama', 'suspence', 'family', 'sci-fi']
categories.each do |category| 
	Category.create(title:category)
end


Video.create(name:"Monk",
	    description:"Former police detective Adrian Monk (Tony Shalhoub), whose photographic memory and amazing ability to piece together tiny clues made him a local legend, has suffered from intensified obsessive-compulsive disorder and a variety of phobias since the unsolved murder of his wife.",
		small_cvr_url:"monk.jpg",
		lrg_cvr_url: "monk_large.jpg",
		category_id: 2 )	


Video.create(name:"Family Guy",
	    description:"Family Guy is an American animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company. The series centers on the Griffins, a dysfunctional ",
	    small_cvr_url:"family_guy.jpg",
	    lrg_cvr_url: "family_guy.jpg",
		category_id: 1 )	

Video.create(name:"South Park",
	    description:"South Park is an American animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences ",
	    small_cvr_url:"south_park.jpg",
	    lrg_cvr_url: "south_park.jpg",
		category_id: 1 )	

Video.create(name:"Futurama",
	    description:"South Park is an American animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences ",
	    small_cvr_url:"futurama.jpg",
	    lrg_cvr_url: "futurama.jpg",
		category_id: 1 )
	
Video.create(name:"King of the Hill",
	    description:"South Park is an American animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences ",
	    small_cvr_url:"king_hill.jpg",
	    lrg_cvr_url: "king_hill.jpg",
		category_id: 1 )
	
Video.create(name:"Charles in Charge",
	    description:"Charles in Charge:  sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences ",
	    small_cvr_url:"charles_charge.jpg",
	    lrg_cvr_url: "charles_charge.jpg",
		category_id: 1 )

Video.create(name:"The Mexican",
	    description:"Charles in Charge:  sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences ",
	    small_cvr_url:"mexican.jpg",
	    lrg_cvr_url: "mexican.jpg",
		category_id: 2 )

Video.create(name:"To kill a mocking Bird",
	    description:"Charles in Charge:  sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences ",
	    small_cvr_url:"kill.jpg",
	    lrg_cvr_url: "kill.jpg",
		category_id: 2 )

Video.create(name:"The Shawshank Redemption",
	    description:"Charles in Charge:  sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences ",
	    small_cvr_url:"shaw.jpg",
	    lrg_cvr_url: "shaw.jpg",
		category_id: 2 )

Video.create(name:"IP Man",
	    description:"Charles in Charge:  sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences ",
	    small_cvr_url:"ipman_small.jpg",
	    lrg_cvr_url: "ipman_small.jpg",
		category_id: 2 )

Video.create(name:"Top Gun",
	    description:"Charles in Charge:  sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences ",
	    small_cvr_url:"top_gun.jpg",
	    lrg_cvr_url: "top_gun.jpg",
		category_id: 2 )

Video.create(name:"The Red Line",
	    description:"Charles in Charge:  sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences ",
	    small_cvr_url:"redline.jpg",
	    lrg_cvr_url: "redline.jpg",
		category_id: 2 )
