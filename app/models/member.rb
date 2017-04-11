# require 'net/http'
# require 'uri'
# require 'json'

class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  belongs_to :birthday
  belongs_to :lookup
  
  attr_accessor :ip_address
  
  def self.generate_password
    'dinklage'
  end
  
  def sync_to_getresponse!
    uri = URI.parse('https://api.getresponse.com/v3/contacts')

    headers = {'Content-Type' => 'application/json', 'X-Auth-Token' => "api-key #{ENV['GETRESPONSE_API_TOKEN']}"}

    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, headers)
    request.body = getresponse_payload.to_json
    
    # Send the request
    response = http.request(request)
    Rails.logger.info(response)
  end
  
  def getresponse_payload
    {
        "name": name,
        "email": email,
        "campaign": {
            "campaignId": ENV['GETRESPONSE_CAMPAIGN_ID']
        }
    }
  end
end
