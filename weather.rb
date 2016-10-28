require 'optparse'
require 'httparty'
require 'json'
require_relative 'location'
# require_relative 'information'

def main
  location = Location.new
  location.set_zipcode
  location.set_response
end

main if __FILE__ == $PROGRAM_NAME

# location.current_conditions
# location.forecast
# location.astronomy
# location.alerts
# location.current_hurricane
