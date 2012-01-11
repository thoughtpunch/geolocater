require "geolocater/version"
require 'faraday'
require 'json'

class Geolocater

  def self.ip_lookup(ip_address)
    
    #IP Regex check
    if /\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/.match(ip_address).nil?
      raise "Not a valid IPv4 address"
    #Localhost Check
    elsif ip_address == "127.0.0.1"
      raise "Can't lookup localhost addresse. Please use an external IP address!"
    else
      #THIS IS THERE THE CODE EVAL WILL GO
      Geolocater.geolocate_ip(ip_address)
    end
  end
  
  private
  def self.geolocate_ip ip_address
    uri = "http://freegeoip.net/json/#{ip_address}"
    http_response = Faraday.get uri
    if http_response.success? == true && http_response.status == 200;
      #JSON PARSE THE BODY
      result = JSON.parse(http_response.body)
      if result["city"].empty?
        raise "Incomplete record. Please try another address"
      else
        return result
      end
    else
      raise "IP address not found"
    end
  end
  
end
