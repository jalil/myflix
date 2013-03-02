# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Category.destroy_all
Friendship.destroy_all
LineItem.destroy_all
Video.destroy_all
Review.destroy_all
User.destroy_all

categories = ['comedy', 'drama', 'suspence', 'family', 'sci-fi']
categories.each do |category| 
	Category.create(title:category)
end

User.create(email: "bob@example.com", full_name: "Bob Hope", password: "bob")
User.create(email: "sam@example.com", full_name: "Sammy Hill", password: "sam")
User.create(email: "adam@example.com", full_name: "Adam Jones", password: "adam")
User.create(email: "dick@example.com", full_name: "Dick Hope", password: "dick")
User.create(email: "jalil@example.com", full_name: "Jalil Mohammed", password: "jalil")
User.create(email: "may@example.com", full_name: "May Kosaka", password: "may")

Video.create(name:"Monk",
	    description:"Former police detective Adrian Monk (Tony Shalhoub), whose photographic memory and amazing ability to piece together tiny clues made him a local legend, has suffered from intensified obsessive-compulsive disorder and a variety of phobias since the unsolved murder of his wife.",
		small_cvr_url:"monk.jpg",
		lrg_cvr_url: "monk_large.jpg",
		category_id: 1 )	


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
Video.create(name:"Shawn of the Dead",
	    description:"Charles in Charge:  sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences ",
	    small_cvr_url:"dead.jpg",
	    lrg_cvr_url: "redline.jpg",
		category_id: 1 )
Video.create(name:"Thing Red Line",
	    description:"Charles in Charge:  sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences ",
	    small_cvr_url:"redline.jpg",
	    lrg_cvr_url: "redline.jpg",
		category_id: 2 )

Review.create(rating: 4, comment: "An achingly slow that are not very likeable. not witty." , video_id: 2, user_id: 1)
Review.create(rating: 2, comment: "Not funny, not interesting, and not witty." , video_id: 2, user_id: 2)
Review.create(rating: 5, comment: "dcouple that are interesting, and not witty." , video_id: 2, user_id: 1)


LineItem.create(video_id: 1, user_id: 1, position: 3)
LineItem.create(video_id: 2, user_id: 1, position: 2)
LineItem.create(video_id: 4, user_id: 2, position: 1)

Friendship.create(user_id:1, friend_id:2)
Friendship.create(user_id:1, friend_id:3)
Friendship.create(user_id:1, friend_id:4)
Friendship.create(user_id:1, friend_id:5)
