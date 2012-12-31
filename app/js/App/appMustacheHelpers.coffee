Handlebars.registerHelper("renderSelect", (valChoices, currentVal, cssAttributes) ->
	attrs = []
	attrs += "#{key}=\"#{value}\" " for key, value of cssAttributes.hash
	selectString = "<select #{attrs}>"
	for option in valChoices when option isnt currentVal
		selectString += "<option #{attrs} value=\"#{option}\">#{option}</option>"
	selectString += "<option #{attrs} selected=\"selected\"value=\"#{currentVal}\">#{currentVal}</option>"
	return "#{selectString}</select>"
)

dateParser = (dateString) ->
	date = new Date(dateString)
	if parseInt(date.toUTCString().match(/(\d{2}):/)[1]) > 12
		dateAttribute = 'PM'
	else
		dateAttribute = 'AM'
	"#{date.toDateString()} #{date.toTimeString().match(/[1-9]+:\d+/)[0]} #{dateAttribute}"


Handlebars.registerHelper('humanDate', dateParser)



