require 'optparse'
require 'httparty'
require 'json'
require_relative 'location'
# require_relative 'information'

def parse_options
  options = {}

  OptionParser.new do |opts|
    opts.on('-z', '--zipcode', 'zip') do |zip|
      options[:zipcode] = zip
    end
  end.parse!
  options
end

def call_api
  options = parse_options
  zipcode = options[:zipcode]

  url = "http://api.wunderground.com/api/b1c58af1b85cc78f/conditions/forecast10day/astronomy/alerts/currenthurricane/q/#{zipcode}.json"

  data = HTTParty.get(url).parsed_response

  analyze_location(data, url)
  # puts JSON.pretty_generate(data)
end

def analyze_location(data, url)
  location = Location.new(data, url)
  location.show_conditions
  location.show_extended_forecast
  location.show_daylight
  location.show_alerts
  location.show_hurricanes
end

def main
  call_api
end

main if __FILE__ == $PROGRAM_NAME

# take user input (via command line)
# pass that into url (query string)

# def get_json(url)
#   HTTParty.get(url).parsed_response
# end
#
# conditions = get_json('http://api.wunderground.com/api/b1c58af1b85cc78f/conditions/q/CA/San_Francisco.json')
# puts JSON.pretty_generate(conditions)
#
# forecast = get_json('http://api.wunderground.com/api/b1c58af1b85cc78f/forecast10day/q/CA/San_Francisco.json')
# puts JSON.pretty_generate(forecast)
#
# astronomy = get_json('http://api.wunderground.com/api/b1c58af1b85cc78f/astronomy/q/Australia/Sydney.json')
# puts JSON.pretty_generate(astronomy)
#
# alerts = get_json('http://api.wunderground.com/api/b1c58af1b85cc78f/alerts/q/IA/Des_Moines.json')
# puts JSON.pretty_generate(alerts)
#
# hurricanes = get_json('http://api.wunderground.com/api/b1c58af1b85cc78f/currenthurricane/view.format.json')
# puts JSON.pretty_generate(hurricanes)
