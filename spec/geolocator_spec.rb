require 'spec_helper'
require 'geolocator'

describe Geolocator do
  let(:locator) { Geolocator.new(@ip) }

  describe "#ip_lookup" do    
    it "throws an ArgumentError error if no parameters passed" do
      expect {Geolocator.new.ip_lookup}.to raise_error(ArgumentError)
    end

    it "throws an ArgumentError error if more than one parameter passed" do
      expect {Geolocator.new("sdfsdf","sdfsadf").ip_lookup}.to raise_error(ArgumentError)
    end
    
    it "only accepts input that passes a basic IP regex" do
      @ip = "sdfsadfsdf"
      expect {locator.ip_lookup}.to raise_error(RuntimeError,"Not a valid IPv4 address")
    end
    
    it "should not accept localhost/loopback address" do
      @ip = "127.0.0.1"
      expect {locator.ip_lookup}.to raise_error(RuntimeError,"Can't lookup localhost address. Please use an external IP address!")
    end
  end
end

