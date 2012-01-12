require "geolocater/version"
require 'ipaddr'  #Ruby IP Address Standard Library
require 'faraday' #HTTP client with https/ssl support
require 'json'    #JSON parser

class Geolocater
  REQUEST_URI = "http://freegeoip.net/json/"
  
  attr_accessor :ip_address

  def initialize(ip_address)
    @ip_address = IPAddr.new ip_address
    raise "IPv6 NOT SUPPORTED" if @ip_address.ipv6?
  end
  
  def geolocate_ip
    http_response = Faraday.get REQUEST_URI + ip_address.to_s
    if http_response.success? == true && http_response.status == 200;
      geolocated_info = JSON.parse(http_response.body)
      if geolocated_info["city"].empty?
        raise "Incomplete record. Please try another IP address"
      else
        return geolocated_info
      end
    end
  end  
   
  class << self
    def geolocate_ip(ip_address)
      geolocator = Geolocater.new(ip_address)
      geolocator.geolocate_ip
    end
  end
  
end
