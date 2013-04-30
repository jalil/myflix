# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.destroy_all
Category.destroy_all
comedies = Category.create(name: "Comedies")
sci-fi   = Category.create(name: "Sci-Fi")
action   = Category.create(name: "Action")
dramas   = Category.create(name: "Dramas")

Video.destroy_all
Video.create(title: "Futurama", description: "space travel!", small_cover_url: "/tmp/futurama.jpg", category: comedies, large_cover_url: '/tmp/monk_large.jpg')
Video.create(title: "Monk", description: "Paranoid SF detective", small_cover_url: "/tmp/monk.jpg", category: dramas, large_cover_url: '/tmp/monk_large.jpg')
Video.create(title: "Family Guy", description: "Peter Griffin and talking dog", small_cover_url: "/tmp/family_guy.jpg", category: comedies, large_cover_url: '/tmp/monk_large.jpg')
south_park = Video.create(title: "South Park", description: "Hippie kids", small_cover_url: "/tmp/south_park.jpg", category: comedies, large_cover_url: '/tmp/monk_large.jpg')

User.destroy_all
jalil = Fabricate(:user, full_name: "Jalil Mohammed")
bob = User.create(full_name: "bob Hope", email: "bob@example.com",admin: 1, password: "password")

Review.destroy_all
south_park.reviews.create(rating: 3, content: "horrible", user: jalil)
south_park.reviews.create(rating: 4, content: "horrible", user: bob)

QueueItem.destroy_all
QueueItem.create(video: south_park, user: bob, position: 1)

Relationship.destroy_all
Relationship.create(influencer: jalil, follower: bob)

