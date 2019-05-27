# README

Summary of implemented features:

- All routes are defined (read only type of routes)
- Content is properly displayed in the views
- Postman shared collections are fully functional
- Views are matching original design of the application

Pending:

- Add buttons to change admin/user views (not required, but makes correction more difficult)
- Navbar is actually only functional for guest_user (registered user and admin navbars are created, but the code must be replaced in 
  views/layouts/application.html.erb, the other navbars are application_registered.html.erb and application_administrator.html.erb)

Postman Collection:

- https://www.getpostman.com/collections/f49a83d33595a5d26f5d

Important:

- In order to access as normal user:
	root = '/'
	links to rants(posts) and profiles are accessible by newsfeed and rants

- Access as an admin:
	root = '/admin'
	links take to the same content as normal users but with different urls (starting with /admin)
	dumpster, blacklist and admin lists are accessible only by typing the corresponding resource url's
	example: for dumpster you type localhost:3000/dumpsters, for blacklist you type localhost:3000/blacklists, 
	for admin list you type localhost:3000/administrators
