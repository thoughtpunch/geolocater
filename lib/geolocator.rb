require "geolocator/version"
require 'faraday'
require 'json'

class Geolocator
  attr_accessor :ip_address

  def initialize(ip_address)
    @ip_address = ip_address
  end

  def ip_lookup
    #IP Regex check
    if /\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/.match(ip_address).nil?
      raise "Not a valid IPv4 address"
    #Localhost Check
    elsif ip_address == "127.0.0.1"
      raise "Can't lookup localhost address. Please use an external IP address!"
    #If valid, pass the ip address to the 'geolocate' method
    else
      FreeGeoIp.new(ip_address).geolocate_ip
    end
  end
end

class Geolocator::FreeGeoIp

  attr_accessor :ip_address

  def initialize(ip_address)
    @ip_address = ip_address
  end

  def geolocate_ip
    #the request URI
    uri = "http://freegeoip.net/json/#{ip_address}"
    #Get the response with Faraday and store to 'http_response' var
    http_response = Faraday.get uri
    #If the HTTP request is successful...
    if http_response.success? == true && http_response.status == 200;
      #JSON PARSE THE BODY
      result = JSON.parse(http_response.body)
      #If the response is missing basic info, like 'city'...
      if result["city"].empty?
        raise "Incomplete record. Please try another address"
      #otherwise return the result
      else
        return result
      end
    #If the HTTP request fails...
    else
      raise "IP address not found"
    end
  end    
end
