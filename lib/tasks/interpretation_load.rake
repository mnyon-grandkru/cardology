require 'net/http'

namespace :load do
  desc "Load interpretation text from production server"
  task :interpretations => :environment do
    endpoint_domain = ENV['INTERPRETATION_API_DOMAIN']
    
    # Load list of interpretation ids
    uri = URI.parse("#{endpoint_domain}/interpretations/ids")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    
    interpretation_ids = JSON.parse(response.body)
    
    # Load each interpretation and save text locally
    interpretation_ids.each do |interpretation_id|
      uri = URI.parse("#{endpoint_domain}/interpretations/#{interpretation_id}")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
    
      interpretation_data = JSON.parse(response.body)
      local_interpretation = Interpretation.find_or_create_by :card_id => interpretation_data['card_id'], :explanation => interpretation_data['explanation'], :reading => interpretation_data['reading']
    end
  end

  desc "Populate seven year interpretations"
  task :seven_year_interpretations => :environment do
    yearly = Interpretation.where :reading => :yearly
    yearly.each do |interpretation|
      Interpretation.create :card_id => interpretation.card_id, :explanation => interpretation.explanation, :reading => :seven_year unless Interpretation.where(:card_id => interpretation.card_id, :reading => :seven_year).exists?
    end
  end

  desc "Populate thirteen year interpretations"
  task :thirteen_year_interpretations => :environment do
    yearly = Interpretation.where :reading => :yearly
    yearly.each do |interpretation|
      Interpretation.create :card_id => interpretation.card_id, :explanation => interpretation.explanation, :reading => :thirteen_year unless Interpretation.where(:card_id => interpretation.card_id, :reading => :thirteen_year).exists?
    end
  end
end
