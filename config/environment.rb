require 'rubygems'
require 'sinatra'
require 'sinatra/partial'
require 'sinatra/assetpack'
require 'sinatra/streaming'
require 'hpricot_scrub'
require 'htmlentities'
require 'json'
require 'haml'
require 'action_controller'

require 'data_mapper'
require 'active_support/inflector'

ROOT_PATH = ::File.expand_path(::File.join( ::File.dirname(__FILE__) , '..'))
$:.unshift File.join(ROOT_PATH, 'lib')
$:.unshift File.join(ROOT_PATH, 'models')

#DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://my.db')
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/db/project.db")

# require models
Dir[::File.join(ROOT_PATH, "models/**/*.rb")].each do |file|
  require file
end

DataMapper.auto_upgrade!

ENV['RACK_ENV'] = 'development' if ENV['RACK_ENV'].nil?



### New Relic
configure :production do
  require 'newrelic_rpm'
end
