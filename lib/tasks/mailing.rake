namespace :mailing do
  desc 'check which mailing lists each member is on'
  task :update => :environment do
    camper = Member.first
    api = camper.get_response_api
    
    Member.find_each do |member|
      contacts = api.contacts :email_address => member.email
      campaigns = contacts.map { |contact| contact['campaign']['name'] rescue nil }.compact
      
      member.update_attribute :campaigns, campaigns
    end
  end
end
