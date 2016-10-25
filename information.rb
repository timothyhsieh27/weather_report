require 'open-uri'
require 'json'

# def show_temperature
# open('http://api.wunderground.com/api/b1c58af1b85cc78f/geolookup/conditions/q/27713.json') do |f|
#   json_string = f.read
#   parsed_json = JSON.parse(json_string)
#   state = parsed_json['location']['state']
#   city = parsed_json['location']['city']
#   temp_f = parsed_json['current_observation']['temp_f']
#   print "Current temperature in #{city}, #{state} is: #{temp_f} degrees. \n"
# end
# end

show_temperature
