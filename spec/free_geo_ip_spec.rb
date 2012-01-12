require "spec_helper"
require "geolocator/free_geo_ip"

describe Geolocator::FreeGeoIp do  
  let(:geo_ip) { Geolocator::FreeGeoIp.new(@ip) }
  describe "#geolocate_ip" do
    it "successfully makes a HTTP request" do
      @ip = "231.4.8.6"
      expect{geo_ip.geolocate_ip.success?}.to be_true
    end
    
    it "throws an error for HTTP statuses other than 200" do
      @ip = "0.0.0.0"
      expect {geo_ip.geolocate_ip}.to raise_error(RuntimeError,"IP address not found")
    end
    
    it "parses the HTTP body with JSON" do
      @ip = "123.45.6.28"
      geo_ip.geolocate_ip.should be_an_instance_of Hash
    end
    
    it "has a value for city" do
      @ip = "123.45.6.28"
      geo_ip.geolocate_ip["city"].should_not be_empty
    end
    
    it "raises a RuntimeError if there isn't a city" do
      @ip = "240.0.0.0"
      expect {geo_ip.geolocate_ip}.to raise_error(RuntimeError,"Incomplete record. Please try another address")
    end
  end      
end
