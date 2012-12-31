RSpec.configure do |config|
	config.color = true
end
CONFIG = YAML.load(File.read(File.expand_path('./config/application.yml')))
require File.expand_path('./models/models.rb')
require 'rspec'
require 'pry'
