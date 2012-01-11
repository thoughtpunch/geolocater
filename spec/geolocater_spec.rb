require 'spec_helper'
require 'geolocater'

describe Geolocater do
  
  class DummyClass
  end
  IP = "127.0.0.1"
  
  before :each do
    @dummy_class = DummyClass.new
    @dummy_class.extend(Geolocater)
  end 
  
  describe "ip_lookup" do
  
  end
end
