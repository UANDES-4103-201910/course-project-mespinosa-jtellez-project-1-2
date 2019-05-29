# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([{email: "jatellez@miuandes.com", password: "123456789", name: "joaco"}, 
	{email: "macakill@miuandes.cl", password: "123456789", name: "maca"}])
posts = Post.create([{"title": "jaja salpica", "creation_date": "nil", "description": "y salpicó po", "location": "Santiago, Chile", "open": "1", "solved": "0", "user": users.first },
{"title": "jaja salpica", "creation_date": "nil", "description": "y salpicó po", "location": "Santiago, Chile", "open": "1", "solved": "0", "user": users.last }])
blacklist = Blacklist.create([{date: "nil", user: users.first}])
dumpster = Dumpster.create([{post: posts.first, date: "nil"}])
geofence = Geofence.create([{location: "Santiago"}])
administrator = Administrator.create([{last_access: "nil", superadmin: "1", geofence: geofence.first, user: users.last}])
profiles = Profile.create([{picture: "nil", biography: "la bio", city: "Santiago", country: "Chile", user: users.first}, 
	{picture: "nil", biography: "la otra bio", city: "Santiago", country: "Chile", user: users.last}])
comments = Comment.create([{user: users.first, post: posts.first, content: "hago comentario"},
	{user: users.last, post: posts.first, content: "hago comentario 2"}, 
	{user: users.first, post: posts.last, content: "hago comentario de nuevo"}, 
	{user: users.last, post: posts.last, content: "hago comentario muchos"}])
votes = Vote.create([{user: users.first, post: posts.first, value: 1},
	{user: users.first, post: posts.last, value: -1},
	{user: users.last, post: posts.first, value: 1},
	{user: users.last, post: posts.last, value: 1}])