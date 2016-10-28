#
require 'open-uri'
require 'json'

class Location
  def initialize(data, url)
    @data = data
    @url = url
  end

  def show_conditions
    open(@url) do |f|
      json_string = f.read
      parsed_json = JSON.parse(json_string)
      location = parsed_json['location']['city']
      temp_f = parsed_json['current_observation']['temp_f']
      print "Current temperature in #{location} is: #{temp_f}\n"
    end
  end
    # conditions = get_json(@url)
    # puts JSON.pretty_generate(conditions)


  def show_extended_forecast
    puts "Forecast 10 days!"
  end

  def show_daylight
    puts "Sunset and sunrise!"
  end

  def show_alerts
    puts "Alerts!"
  end

  def show_hurricanes
    p "Matthew!"
  end

end
