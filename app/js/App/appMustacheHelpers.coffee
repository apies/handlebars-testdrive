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

humanMoney  = (moneyString) ->
	splitString = moneyString.toString().split("").reverse() 
	n = 0
	formattedMoney = splitString.reduce (formattedString, digit) ->
		n += 1
		if n%3 is 0 and n < splitString.length
			"#{formattedString},#{digit}"
		else
			"#{formattedString}#{digit}"
	"$#{formattedMoney.split("").reverse().join("")}" 


Handlebars.registerHelper('humanDate', dateParser)

Handlebars.registerHelper('humanMoney', humanMoney)



