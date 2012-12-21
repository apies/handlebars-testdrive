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

class MailTemplateView extends Backbone.View

	initialize: ->
		@template = $('#mailerTemplate').html()
		@
	render: ->
		mailTemplate = Handlebars.compile(@template)
		$(@el).html(mailTemplate(@getBootstrappedData()))
		@
	getBootstrappedData: ->
		data = JSON.parse($('#bootstrap').text())
		console.log data
		@







$(document).ready ->
	@app = window.app ? {}
	@app.authView = new AuthView()
	@app.MailTemplateView = MailTemplateView

	