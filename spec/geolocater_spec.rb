require 'spec_helper'
require 'geolocater'

describe Geolocater do
  GOOGLE_DNS_IP   = "8.8.8.8"
  OPENDNS_IPv6_IP = "2620:0:ccc::2"
  BAD_IP          = "0.0.0.0"
  EMPTY_IP        = "240.0.0.0"
  
  describe "#new" do
    it "returns a new Geolocater object" do
      @geolocater = Geolocater.new GOOGLE_DNS_IP
    end
    
    it "throws an ArgumentError error if no parameters passed" do
      expect {Geolocater.new }.to raise_error(ArgumentError)
    end

    it "throws an ArgumentError error if more than one parameter passed" do
      expect {Geolocater.new GOOGLE_DNS_IP, OPENDNS_IPv6_IP}.to raise_error(ArgumentError)
    end
    
    it "throws a RuntimeError error if initialized with an IPv6 address" do
      expect {Geolocater.new OPENDNS_IPv6_IP}.to raise_error(RuntimeError,"IPv6 NOT SUPPORTED")
    end
  end
  
  describe "::geolocate_ip" do
  
    it "successfully makes a HTTP request" do
      expect{(Geolocater.new GOOGLE_DNS_IP).success?}.to be_true
    end
    
    it "parses the HTTP body with JSON and returns a Hash" do
      (Geolocater.new GOOGLE_DNS_IP).geolocate_ip.should be_an_instance_of Hash
    end
    
    it "has a value for city otherwise it otherwise it throws a RuntimeError" do
      (Geolocater.new GOOGLE_DNS_IP).geolocate_ip["city"].should_not be_empty
      expect {(Geolocater.new EMPTY_IP).geolocate_ip}.to raise_error(RuntimeError,"Incomplete record. Please try another IP address")
    end
  end
  
  describe "#geolocate_ip" do
    it "should return the same results as calling the instance method alone" do
      @geolocater = (Geolocater.new GOOGLE_DNS_IP).geolocate_ip
      Geolocater.geolocate_ip(GOOGLE_DNS_IP).should eql @geolocater
    end
  end
  
end

