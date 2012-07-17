require 'action_mailer'

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.view_paths = File.dirname(__FILE__)+"/../views/"
ActionMailer::Base.smtp_settings = JSON.parse($smtp_settings).symbolize_keys unless $smtp_settings.nil?

require 'haml/template/plugin'
require 'uuid'


class UserMailer < ActionMailer::Base
  
    default :from => "Expediteur <notifications@example.com>"

   def newsletter(user, tid)
      @user = user
      @url  = "http://example.com/login"
      user.token = UUID.new.generate(:compact)
      puts user.token
      if mail(:to => user.email, :subject => "Your Newsletter")
        user.sent_at = Time.now
        user.updated_at = Time.now
        user.save!
      end
      
   end
end