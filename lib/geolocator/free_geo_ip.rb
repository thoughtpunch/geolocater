class Geolocator
  class FreeGeoIp

    attr_accessor :ip_address

    def initialize(ip_address)
      @ip_address = ip_address
    end

    def geolocate_ip
      uri = "http://freegeoip.net/json/#{ip_address}"
      http_response = Faraday.get uri

      if http_response.success? == true && http_response.status == 200
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
end
