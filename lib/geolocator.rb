require "geolocator/version"
require 'faraday'
require 'json'
require "geolocator/free_geo_ip"

class Geolocator
  attr_accessor :ip_address

  def initialize(ip_address)
    @ip_address = ip_address
  end

  def ip_lookup
    if /\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/.match(ip_address).nil?
      raise "Not a valid IPv4 address"
    elsif ip_address == "127.0.0.1"
      raise "Can't lookup localhost address. Please use an external IP address!"
    else
      FreeGeoIp.new(ip_address).geolocate_ip
    end
  end
end
