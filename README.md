Geolocator
==========
Yet Another IP Geolocation Gem for Fun and Profit!
--------------------------------------------------

### Installation
`gem install geolocator`

### Usage
Pass any properly formatted IPv4 address string to a new instance of Geolocator like so.

`Geolocator.ip_lookup(IP_ADDRESS_STRING)`

and get back a JSON Hash of the results

`=> {"city"=>"CITY", "region_code"=>"ST", "region_name"=>"Region Name", 
     "metrocode"=>"999", "zipcode"=>"98765", "longitude"=>"-92.23", 
     "country_name"=>"United States", "country_code"=>"US", 
     "ip"=>"IP_ADDRESS", "latitude"=>"27.54"}`

### Details
* This library uses the free (and very good) [freegeoip.net](http://freegeoip.net) REST API.
* Results are returned in JSON format. For friendlier Ruby object-like results (and better nil handling), pipe the result hash into a new [Hashie::Mash](https://github.com/intridea/hashie) like so:

`Hashie::Mash.new(Geolocator.ip_lookup(IP_ADDRESS_STRING))`

### Future Features
* Add multiple geolocation services in the event the freegeoip service goes down

### How You Can Help
* Suggest additional tests/refactoring
* Submit a pull request

### Thanks!
* <dbarrett83@gmail.com>
* [Twitter](http://www.twitter.com/thoughtpunch)
