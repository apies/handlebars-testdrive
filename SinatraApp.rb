require 'sinatra/base'
require 'sinatra/assetpack'
require 'sinatra'
require 'sass'
require 'coffee_script'
require 'yaml'
CONFIG = YAML.load(File.read(File.expand_path('./config/application.yml')))
require './models/move_api_auth.rb'

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
    @result = MoveApi.get_listings.to_hash
    @result['filler'] = {'number' => 7, 'date' => 'Jan 17 1984 1pm'}
    #puts result.body #.class
    #@listings = result.to_hash['listings'] #['tasks']
    #result['listings']
    @result
    erb :home_alert
  end
  
  run!

end

