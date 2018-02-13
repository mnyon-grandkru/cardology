GetResponse.configure do |config|
  config.api_key = ENV['GETRESPONSE_API_TOKEN']
  config.api_endpoint = 'https://api.getresponse.com'
end
