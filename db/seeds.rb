# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Category.destroy_all
categories = ['comedy', 'drama', 'suspence', 'family', 'sci-fi']
categories.each do |category| 
	Category.create(title:category)
end

User.destroy_all
bob = User.create(email: "bob@example.com", full_name: "Bob Hope", password: "bob", admin: true)
sam = User.create(email: "sam@example.com", full_name: "Sammy Hill", password: "sam")
adam = User.create(email: "adam@example.com", full_name: "Adam Jones", password: "adam")
User.create(email: "dick@example.com", full_name: "Dick Hope", password: "dick")
User.create(email: "jalil@example.com", full_name: "Jalil Mohammed", password: "jalil")
User.create(email: "may@example.com", full_name: "May Kosaka", password: "may")


future = Video.create(name: "Futurama", description: "space travel!", small_image: "futurama.jpg", category_id: 1, large_image: 'monk_large.jpg')


LineItem.destroy_all
LineItem.create(video_id: 1, user_id: 1, position: 1)

Relationship.destroy_all
Relationship.create(influencer_id: 1, follower_id: 2)
Relationship.create(influencer_id: 1, follower_id: 3)
