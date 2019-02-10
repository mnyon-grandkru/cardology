namespace :mailing do
  desc 'check which mailing lists each member is on'
  task :update => :environment do
    Member.find_each do |member|
      member.update_attribute :campaigns, member.mail_campaigns
    end
  end
end
