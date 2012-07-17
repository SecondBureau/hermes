require "user_mailer"

namespace :mailer do 
  desc "send newsletter"
  task :send_newsletter do
    User.all.each do |user|
      UserMailer.newsletter(user, 1).deliver
    end
  end
end