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
end
