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

User.create(email: "bob@example.com", full_name: "Bob Hope", password: "bob", admin: true)
User.create(email: "sam@example.com", full_name: "Sammy Hill", password: "sam")
User.create(email: "adam@example.com", full_name: "Adam Jones", password: "adam")
User.create(email: "dick@example.com", full_name: "Dick Hope", password: "dick")
User.create(email: "jalil@example.com", full_name: "Jalil Mohammed", password: "jalil")
User.create(email: "may@example.com", full_name: "May Kosaka", password: "may")





Friendship.create(user_id:1, friend_id:2)
Friendship.create(user_id:1, friend_id:3)
Friendship.create(user_id:1, friend_id:4)
Friendship.create(user_id:1, friend_id:5)
