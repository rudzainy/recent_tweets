# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

require 'byebug'

require 'time'

require 'twitter'
require 'omniauth-twitter'

require 'yaml'

TWITTER_API = YAML.load_file('config/secret.yaml')

$twitter_access = Twitter::REST::Client.new do |config|
  config.consumer_key = TWITTER_API['API_Key']
  config.consumer_secret = TWITTER_API['API_Secret']
  config.access_token = TWITTER_API['Access_Token']
  config.access_token_secret = TWITTER_API['Access_Token_Secret']
end