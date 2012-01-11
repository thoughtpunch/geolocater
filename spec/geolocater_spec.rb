require 'spec_helper'
require 'geolocater'

describe Geolocater do

  describe "#ip_lookup" do    
    it "throws an ArgumentError error if no parameters passed" do
      expect {Geolocater.ip_lookup}.to raise_error(ArgumentError)
    end

    it "throws an ArgumentError error if more than one parameter passed" do
      expect {Geolocater.ip_lookup("sdfsdf","sdfsadf")}.to raise_error(ArgumentError)
    end
    
    it "only accepts input that passes a basic IP regex" do
      expect {Geolocater.ip_lookup("sdfsadfsdf")}.to raise_error(RuntimeError,"Not a valid IPv4 address")
    end
    
    it "should not accept localhost/loopback address" do
      expect {Geolocater.ip_lookup("127.0.0.1")}.to raise_error(RuntimeError,"Can't lookup localhost address. Please use an external IP address!")
    end
  end
  
  describe "#geolocate_ip" do
    it "successfully makes a HTTP request" do
      expect{Geolocater.ip_lookup("231.4.8.6").success?}.to be_true
    end
    
    it "throws an error for HTTP statuses other than 200" do
      expect {Geolocater.ip_lookup("0.0.0.0")}.to raise_error(RuntimeError,"IP address not found")
    end
    
    it "parses the HTTP body with JSON" do
      Geolocater.ip_lookup("123.45.6.28").should be_an_instance_of Hash
    end
    
    it "has a value for city" do
      @result = Geolocater.ip_lookup("123.45.6.28")["city"].should_not be_empty
      expect {Geolocater.ip_lookup("240.0.0.0")}.to raise_error(RuntimeError,"Incomplete record. Please try another address")
    end
    
  end      
end

