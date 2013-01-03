require 'sinatra/base'
require 'sinatra/assetpack'
require 'sinatra'
require 'sass'
require 'coffee-script'
require 'yaml'
require 'pry'
CONFIG = YAML.load(File.read(File.expand_path('./config/application.yml')))
#binding.pry
require './models/models.rb'
require 'handlebars'
require 'json'

class App < Sinatra::Base
  
  set :root, File.dirname(__FILE__)
  register Sinatra::AssetPack

  assets {
    serve '/js',     from: 'app/js'        # Optional
    serve '/css',    from: 'app/css'       # Optional
    serve '/images', from: 'app/images'    # Optional

    # The second parameter defines where the compressed version will be served.
    # (Note: that parameter is optional, AssetPack will figure it out.)
    js :app, '/js/app.js', [
      '/js/vendor/**/*.js',
      '/js/app/**/*.js'
    ]

    css :application, '/css/application.css', [
      '/css/screen.css'
    ]

    js_compression  :jsmin      # Optional
    css_compression :sass       # Optional
  }
  
  get '/' do
    erb :index
  end

  get '/my_mail' do
    @result = Move.get_listings(:open_house_date_min => '1-1-2012').to_hash
    @result['filler'] = {'number' => 7, 'date' => 'Jan 17 1984 1pm'}
    @result['listings'] = @result['listings'][0...4]
    
    @result['saved_searches'] = [
      {:name => 'Dream Houses', :query_string => 'All Houses in Saratoga CA', :listings => @result['listings'] },
      {:name => 'Taco Stands', :query_string => 'All Houses that smell ', :listings => @result['listings'] }
    ]
    @result
    erb :home_alert_composite
  end

  get '/my_server_mail' do
    @result = Move.get_listings(:distressed => 'foreclosure').to_hash
    @result['filler'] = {'number' => 7, 'date' => 'Jan 17 1984 1pm'}
    @result['listings'] = @result['listings'][0...4]
    
    @result['saved_searches'] = [
      {:name => 'Dream Houses', :query_string => 'All Houses in Saratoga CA 5 rooms 1 pool close to hiking', :listings => @result['listings'] },
      {:name => 'Taco Stands', :query_string => 'All Houses that smell LIKE %tacos% ', :listings => @result['listings'] }
    ]
    @result

    handlebars = Handlebars::Context.new
    template = handlebars.compile(File.read('./templates/home_alert.handlebars'))
    template.call(@result)

  end
  
  run!

end

