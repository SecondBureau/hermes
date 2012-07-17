# encoding: utf-8

require 'sinatra'
require 'haml'

require_relative 'config/environment'

module Hermes

  def self.env
    ENV['RACK_ENV']
  end

  def self.development?
    Hermes.env.eql?('development')
  end

  def self.production?
    Hermes.env.eql?('production')
  end

  def self.test?
    Hermes.env.eql?('test')
  end

  def self.demo?
    Hermes.env.eql?('demo')
  end

  def self.heroku?
    Hermes.production? || Hermes.demo?
  end

  def self.root
    Pathname.new ROOT_PATH
  end

  def self.logger
    Hermes::Logger.logger
  end

  class Application < Sinatra::Base
   set :root, File.dirname(__FILE__)
   register Sinatra::AssetPack
   register Sinatra::Partial
   register Sinatra::Streaming

   assets {
       serve '/js',     from: '/assets/js'        # Optional
       serve '/css',    from: '/assets/css'       # Optional
       serve '/images', from: '/assets/images'    # Optional

       # The second parameter defines where the compressed version will be served.
       # (Note: that parameter is optional, AssetPack will figure it out.)
       js :app, [ 'js/jquery-1.7.2.min.js' ]

       css :application, [ 'css/style.css' ]

     }

    helpers do

      def link_to(url,text=url,opts={})
        attributes = ""
        opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
        "<a href=\"#{url}\" #{attributes}>#{text}</a>"
      end

    end

    get '/check/if/app/is/alive' do
      'alive'
    end

    get '/robots.txt', :host_name => /^production-hermes\./ do
      content_type 'text/plain'
      "User-Agent: * \nDisallow: /"
    end

    get '/robots.txt' do
      content_type 'text/plain'
      "User-Agent: * \nDisallow: "
    end

    get %r{^/api/u/([0-9]{1,5}?)/([0-9]{1})/([0-9a-z]{32}).jpg} do
      user_id, newsletter_id, token = params[:captures]
      user = User.get(user_id)
      if token.eql?(user.token)
        user.last_read_at = Time.now
        user.read_count += 1
        user.updated_at = Time.now
        user.save!
      end
      # send_file fails on heroku
      send_file File.join(settings.root, 'assets/images/1/logo.jpg')
    end


  end
end


require_relative 'config/initializer'
