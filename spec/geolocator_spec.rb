require 'spec_helper'
require 'geolocator'

describe Geolocator do

  describe "#ip_lookup" do    
    it "throws an ArgumentError error if no parameters passed" do
      expect {Geolocator.new.ip_lookup}.to raise_error(ArgumentError)
    end

    it "throws an ArgumentError error if more than one parameter passed" do
      expect {Geolocator.new("sdfsdf","sdfsadf").ip_lookup}.to raise_error(ArgumentError)
    end
    
    it "only accepts input that passes a basic IP regex" do
      expect {Geolocator.new("sdfsadfsdf").ip_lookup}.to raise_error(RuntimeError,"Not a valid IPv4 address")
    end
    
    it "should not accept localhost/loopback address" do
      expect {Geolocator.new("127.0.0.1").ip_lookup}.to raise_error(RuntimeError,"Can't lookup localhost address. Please use an external IP address!")
    end
  end
end

describe Geolocator::FreeGeoIp do  
  describe "#geolocate_ip" do
    it "successfully makes a HTTP request" do
      expect{Geolocator::FreeGeoIp.new("231.4.8.6").geolocate_ip.success?}.to be_true
    end
    
    it "throws an error for HTTP statuses other than 200" do
      expect {Geolocator::FreeGeoIp.new("0.0.0.0").geolocate_ip}.to raise_error(RuntimeError,"IP address not found")
    end
    
    it "parses the HTTP body with JSON" do
      Geolocator::FreeGeoIp.new("123.45.6.28").geolocate_ip.should be_an_instance_of Hash
    end
    
    it "has a value for city" do
      @result = Geolocator::FreeGeoIp.new("123.45.6.28").geolocate_ip["city"].should_not be_empty
      expect {Geolocator::FreeGeoIp.new("240.0.0.0").geolocate_ip}.to raise_error(RuntimeError,"Incomplete record. Please try another address")
    end
  end      
end


