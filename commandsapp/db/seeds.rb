# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([{email: "jatellez@miuandes.com", password: "123456789", name: "joaco", role: 2}, 
	{email: "macakill@miuandes.cl", password: "123456789", name: "maca", role: 2}])
posts = Post.create([{"title": "rant 1", "creation_date": "nil", "description": "first description", "location": "Santiago, Chile", "open": "0", "solved": "0", "user": users.first, latitude: 0.0, longitude: 0.0, country: "Chile" },
{"title": "rant 2", "creation_date": "nil", "description": "rant", "location": "Santiago, Chile", "open": "1", "solved": "0", "user": users.last, latitude: 0.0, longitude: 0.0, country: "Argentina" }])
blacklist = Blacklist.create([{date: "nil", user: users.first}])
dumpster = Dumpster.create([{post: posts.first, date: "nil"}])
geofence = Geofence.create([{location: "Afghanistan"}, {location: "Albania"}, {location: "Algeria"}, {location: "Andorra"}, {location: "Angola"}, {location: "Antigua and Barbuda"},
	{location: "Argentina"}, {location: "Armenia"}, {location: "Australia"}, {location: "Austria"}, {location: "Azerbaijan"}, {location: "Bahamas"}, 
	{location: "Bahrain"}, {location: "Bangladesh"}, {location: "Barbados"}, {location: "Belarus"}, {location: "Belgium"}, {location: "Belize"}, {location: "Benin"}, 
	{location: "Bhutan"}, {location: "Bolivia"}, {location: "Boznia and Herzegovina"}, {location: "Botswana"}, {location: "Brazil"}, {location: "Brunei"},
	{location: "Bulgaria"}, {location: "Burkina Faso"}, {location: "Burundi"}, {location: "Cabo Verde"}, {location: "Cambodia"}, {location: "Cameroon"}, 
	{location: "Canada"}, {location: "Central African Republic"}, {location: "Chad"}, {location: "Chile"}, {location: "China"}, {location: "Colombia"}, 
	{location: "Comoros"}, {location: "Congo, Democratic Republic of the"}, {location: "Congo, Republic of the"}, {location: "Costa Rica"}, {location: "Coste d'lvoire"},
	{location: "Croatia"}, {location: "Cuba"}, {location: "Cyprus"}, {location: "Czechia"}, {location: "Denmark"}, {location: "Dominican Republic"}, 
	{location: "Ecuador"}, {location: "Egypt"}, {location: "Estonia"}, {location: "Ethiopia"}, {location: "Finland"}, {location: "France"}, {location: "Germany"}, 
	{location: "Ghana"}, {location: "Grece"}, {location: "Guatemala"}, {location: "Guyana"}, {location: "Haiti"}, {location: "Honduras"}, {location: "Hungary"}, 
	{location: "Iceland"}, {location: "Indonesia"}, {location: "Iran"}, {location: "Iraq"}, {location: "Ireland"}, {location: "Israel"}, {location: "Italy"}, 
	{location: "Jamaica"}, {location: "Japan"}, {location: "Kenya"}, {location: "Kuwait"}, {location: "Lesotho"}, {location: "Lithuania"}, {location: "Madagascar"}, 
	{location: "Malaysia"}, {location: "Mexico"}, {location: "Namibia"}, {location: "Nepal"}, {location: "Netherlands"}, {location: "Nicaragua"}, {location: "New Zeland"}, 
	{location: "Niger"}, {location: "North Korea"}, {location: "Norway"}, {location: "Oman"}, {location: "Panama"}, {location: "Paraguay"}, {location: "Peru"}, 
	{location: "Poland"}, {location: "Portugal"}, {location: "Qatar"}, {location: "Romania"}, {location: "Russia"}, {location: "Rwanda"}, {location: "San Marino"}, 
	{location: "Saudi Arabia"}, {location: "Senegal"}, {location: "Serbia"}, {location: "Singapore"}, {location: "Somalia"}, {location: "South Africa"}, 
	{location: "South Korea"}, {location: "Spain"}, {location: "Sudan"}, {location: "Suriname"}, {location: "Sweden"}, {location: "Switzerland"}, 
	{location: "Syria"}, {location: "Taiwan"}, {location: "Tanzania"}, {location: "Thailand"}, {location: "Tonga"}, {location: "Trinidad and Tobago"}, 
	{location: "Tunisia"}, {location: "Turkey"}, {location: "Turkmenistan"}, {location: "Tuvalu"}, {location: "Uganda"}, {location: "Ukraine"}, 
	{location: "United Arab Emirates"}, {location: "United Kingdom"}, {location: "United States"}, {location: "Uruguay"}, {location: "Uzbekistan"}, 
	{location: "Vanuatu"}, {location: "Vatican City"}, {location: "Venezuela"}, {location: "Vietnam"}, {location: "Yemen"}, {location: "Zambia"}, 
	{location: "Zimbawe"}, {location: "Wakanda"}, {location: "Asgard"}])
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
superadmin = Administrator.create([{superadmin: 1, geofence: geofence.first, user: users.first}])