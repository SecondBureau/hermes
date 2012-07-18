require 'action_mailer'

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.view_paths = File.dirname(__FILE__)+"/../views/"
ActionMailer::Base.smtp_settings = JSON.parse($smtp_settings).symbolize_keys unless $smtp_settings.nil?

require 'haml/template/plugin'
require 'uuid'


class UserMailer < ActionMailer::Base

    default :from => "ACAPITAL <chinaoutbound@acapital.hk>"

   def newsletter(user, template)
      @user = user
      @template = template
      @path_root  = "http://#{$domain}/images/#{template.id}/"
      user.token = UUID.new.generate(:compact)
      @logo_url = "#{$domain}/api/u/#{user.id}/#{template.id}/#{user.token}.jpg"
      if mail(:to => user.email, :subject => template.title)
        user.sent_at = Time.now
        user.updated_at = Time.now
        user.save!
      end

   end
end
