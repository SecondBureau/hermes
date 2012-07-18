require "user_mailer"

namespace :mailer do
  desc "send newsletter"
  task :send_newsletter do
    User.all.each do |user|
      puts "#{user.email}"
      UserMailer.newsletter(user, Template.get(1)).deliver
      UserMailer.newsletter(user, Template.get(2)).deliver
    end
  end
end
