class AuthView extends Backbone.View

	el: '#auth_form'
	tagName: 'form'

	initialize: ->
		@

	authTest: (event) ->
		event.preventDefault()
		console.log 'auth test!!!'
		username = $('#username').val()
		password = $('#password').val()
		console.log "#{username}:#{password}"
		token = @getToken(username, password)
		console.log token
	events:
		'click #go_button' : 'authTest'

	getToken: (username, password) ->
		$.ajax( 
			url: "https://api.move.com/v2/auth/gen/PRO/ssl/real?client_id=jsc"
			dataType: 'json'
			beforeSend: (xhr) ->
				auth64String =  base64_encode("#{username}:#{password}")
				xhr.setRequestHeader("Authorization", "basic #{auth64String}")
			success: (json, s, xhr) ->
				console.log json 
				console.log json.api_token
			error: (xhr) ->
				console.log xhr.responseText
		)

roleName = 'PRO'
sequenceNumber = 'ssl'

#Handlebars.registerPartial("listing", $('#listing_template').html() )
class MailTemplateView extends Backbone.View
	el: '#targetDiv'

	initialize: ->
		@template = $('#blue_bar').html()
		Handlebars.registerPartial("listing", $('#listing_template').html() )
		Handlebars.registerPartial('thing', '<h1>HELLO NAME {{name}}</h1>')
		Handlebars.registerPartial("search", $('#saved_search_template').html() )
		#@header_bars_template = Handlebars.compile($('#header_bars').html())
		#@first_listings_template = Handlebars.compile($('#listings_first').html())
		#@saved_searches_template = Handlebars.compile($('#saved_searches').html())
		@mailerTemplate = Handlebars.compile($('#mail_template').html())
		@
	render: ->
		data = @getBootstrappedData()
		mailTemplate = Handlebars.compile(@template)
		#console.log @first_listings_template(listings: 1023)
		#$('#targetDiv').append(mailTemplate(data)).append(@header_bars_template(data)).append(@saved_searches_template(data))
		$('#targetDiv').append(@mailerTemplate(data))
		#console.log 
		
		#.append(@first_listings_template(data))
		
		#$('')
		@
	getBootstrappedData: ->
		data = JSON.parse($('#bootstrap').text())
		#console.log(data['matching_rows'])
		data







$(document).ready ->
	Handlebars.registerPartial("listing", $('#listing_template').html() )
	@app = window.app ? {}
	@app.authView = new AuthView()
	@app.MailTemplateView = MailTemplateView

	