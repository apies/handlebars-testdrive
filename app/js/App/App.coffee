
@app = window.app ? {}


#jQuery ->
@App = window.app ? {}
@App = Ember.Application.create()
@App.Router.map( (match) ->
	match("/").to("home")
)

@App.HomeRoute = Ember.Route.extend(

	# renderTemplates: () ->
	# 	console.log 'hello ember js fail'
	# 	@render('home')
	setupControllers: (controller) ->
		controller.set('blobs', ["blob1", "blob2", "blob3"])
		controller.set('listings', App.Listing.find())
)

@App.HomeController = Ember.Controller.extend(
	blobs: null
	listings: null

)

@App.Search = DS.Model.extend(
	listings: DS.hasMany('App.Listing')
	name: DS.attr('string')
	query_string: DS.attr('string')

)

@App.Listing = DS.Model.extend(
	search: DS.belongsTo('App.Search')
	baths: DS.attr('number')
	beds: DS.attr('number')
	last_update: DS.attr('date')
	list_date: DS.attr('date')
	lot_sqft: DS.attr('number')
	mls_id: DS.attr('string')
	price: DS.attr('number')
)
@App.Store = DS.Store.extend(
  revision: 11
  adapter: DS.RESTAdapter.create(bulkCommit: false )
)

# jQuery( => 
# 	@App.initialize()
# )
