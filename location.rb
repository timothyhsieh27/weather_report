#
require 'open-uri'
require 'json'
#
class Location

  def set_zipcode
    puts 'Which zipcode would you like a report for?'
    @zipcode = gets.chomp
  end

  def set_response
    puts 'Which report would you like?'
    puts 'Please select Conditions, Daylight, Forecast, Alerts, or Hurricanes: '
    @report = gets.chomp.downcase
    select_mode
  end

  def select_mode
    loop do
      if @report == 'conditions'
        run_conditions
      elsif @report == 'daylight'
        run_daylight
      elsif @report == 'forecast'
        run_forecast
      elsif @report == 'alerts'
        run_alerts
      elsif @report == 'hurricanes'
        run_hurricanes
      else
        puts 'Please select a valid report: '
        @report = gets.chomp.downcase
      end
    end
  end

  def zip_cache_exists?
    File.exist?("#{@zipreport}.json")
  end

  def load_zip_cache
    @data = JSON.parse(File.read("#{@zipreport}.json"))
  end

  def retrieve_info
    key = 'b1c58af1b85cc78f'
    path = 'conditions/forecast10day/astronomy/alerts/currenthurricane/q'
    @url = "http://api.wunderground.com/api/#{key}/#{path}/#{@zipcode}.json"
    @data = HTTParty.get(@url).parsed_response
    save_cache
  end

  def save_cache
    File.write("#{@zipreport}.json", JSON.dump(@data))
  end

  def run_conditions
    @zipreport = @zipcode + @report
    check_conditions
    set_zipcode
    set_response
  end

  def check_conditions
    if zip_cache_exists?
      load_zip_cache

      print_conditions
    else
      retrieve_conditions
    end
  end

  def retrieve_conditions
    retrieve_info
    print_conditions
  end

  def print_conditions
    data = @data['current_observation']

    puts "Weather: #{data['weather']}"
    puts "Temperature (Fahrenheit): #{data['temp_f']}"
    puts "Humidity: #{data['relative_humidity']}"
    puts "Wind Speed (mph): #{data['wind_mph']}"
    puts "Pressure (mb): #{data['pressure_mb']}"
    puts "Dewpoint (Fahrenheit): #{data['dewpoint_f']}"
    puts "Heat Index (Fahrenheit): #{data['heat_index_f']}"
    puts "Windchill (Fahrenheit): #{data['windchill_f']}"
    puts "Feels Like (Fahrenheit): #{data['feelslike_f']}"
    puts "Visibility (mi): #{data['visibility_mi']}"
    puts "UV: #{data['UV']}"
    puts "Precipitation (in): #{data['precip_today_in']}"
  end

  def run_daylight
    @zipreport = @zipcode + @report
    check_daylight
    set_zipcode
    set_response
  end

  def check_daylight
    if zip_cache_exists?
      load_zip_cache
      print_daylight
    else
      retrieve_daylight
    end
  end

  def retrieve_daylight
    retrieve_info
    print_daylight
  end

  def print_daylight
    data = @data['moon_phase']
    sunrise = data['sunrise']
    sunset = data['sunset']

    puts "Sunrise is at #{sunrise['hour'].to_i}:#{sunrise['minute'].to_i}AM"
    puts "Sunset is at #{sunset['hour'].to_i}:#{sunset['minute'].to_i}PM"
  end

  def run_forecast
    @zipreport = @zipcode + @report
    check_forecast
    set_zipcode
    set_response
  end

  def check_forecast
    if zip_cache_exists?
      load_zip_cache
      print_forecast
    else
      retrieve_forecast
    end
  end

  def retrieve_forecast
    retrieve_info
    print_forecast
  end

  def print_forecast
    day = @data['forecast']['txt_forecast']['forecastday']

   puts "Ten Day Forecast: \n #{day[0]['title']} - #{day[0]['fcttext']} \n " \
   "#{day[2]['title']} - #{day[2]['fcttext']} \n " \
   "#{day[4]['title']} - #{day[4]['fcttext']} \n " \
   "#{day[6]['title']} - #{day[6]['fcttext']} \n " \
   "#{day[8]['title']} - #{day[8]['fcttext']} \n " \
   "#{day[10]['title']} - #{day[10]['fcttext']} \n " \
   "#{day[12]['title']} - #{day[12]['fcttext']} \n " \
   "#{day[14]['title']} - #{day[14]['fcttext']} \n " \
   "#{day[16]['title']} - #{day[16]['fcttext']} \n " \
   "#{day[18]['title']} - #{day[18]['fcttext']} "
  end

  def run_alerts
    @zipreport = @zipcode + @report
    check_alerts
    set_zipcode
    set_response
  end

  def check_alerts
    if zip_cache_exists?
      load_zip_cache
      print_alerts
    else
      retrieve_alerts
    end
  end

  def retrieve_alerts
    retrieve_info
    print_alerts
  end

  def print_alerts
    alerts = @data['alerts']
    if alerts.empty?
      puts "There are no alerts for this area."
    else
      puts "Alerts: #{alerts[0]['description']}"
    end
  end

  def run_hurricanes
    @zipreport = @zipcode + @report
    check_hurricanes
    set_zipcode
    set_response
  end

  def check_hurricanes
    if zip_cache_exists?
      load_zip_cache
      print_hurricanes
    else
      retrieve_hurricanes
    end
  end

  def retrieve_hurricanes
    retrieve_info
    print_hurricanes
  end

  def print_hurricanes
    hurricane = @data['currenthurricane'][0]['stormInfo']['stormName_Nice']
    puts "Hurricane: #{hurricane}"
  end
end
