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

require 'erb'
require 'bcrypt'
require 'securerandom'
require 'pry'
require 'carrierwave'
require  'fog'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

env_config = YAML.load_file(APP_ROOT.join('config', 'aws.yaml'))

CarrierWave.configure do |config|
  config.fog_credentials = {
    config.provider             = 'AWS'
    config.aws_access_key_id    = env_config['AWSAccessKeyId']
    config.aws_secret_access_key= env_config['AWSAccessKey']
  }
  config.fog_directory  = 'Beautipoll'
end



