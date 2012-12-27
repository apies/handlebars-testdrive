# Install:


#### Step 1
* make a config directory at root of project, in the config directory drop the application.yml I emailed you

#### Step 2
* `bundle install`

#### Step 3
* email Alan P about any error messages that come up

#### Step 4
* `ruby SinatraApp`

#### Step 5
* repeat step 3

#### Step 6
* navigate to localhost:4567

#### Step 7
* repeat step 3 :)



# Things to Note:

### localhost:4567/my_ server _ mail
* in this view the server is recieving a JSON response from move API then rendering the template serverside with ruby. This is the likely work flow for rendering template mail. 

### localhost:4567/my_ mail
* in this view the client is recieving a JSON response from move API then rendering it in the browser with javascript handlebars. Just showing this to illustrate handlebars is available in multiple languages/environments.
* possibly multi-environment templates would get you more re-usable UI components, but no guarantees as in the case of mailer templates where you are stuck using 1990s tables html strategies. 


