require 'faraday'
require 'figaro'
require 'pry'
require 'json'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjects
  attr_reader :neos

  def initialize(formatted_asteroid_data, parsed_asteroids_data)
    @neos =
        {
          asteroid_list: formatted_asteroid_data,
          biggest_asteroid: largest_asteroid(parsed_asteroids_data),
          total_number_of_asteroids: parsed_asteroids_data.count
        }
  end

  def self.find_neos_by_date(date)
    asteroids_list_data = asteroids_list_data_service(date)
    parsed_asteroids_data = parsed_asteroids_data(asteroids_list_data, date)
    total_number_of_asteroids = parsed_asteroids_data.count
    formatted_asteroid_data = formatted_asteroid_data(parsed_asteroids_data)
    self.new(formatted_asteroid_data, parsed_asteroids_data)
  end

  def largest_asteroid(parsed_asteroids_data)
    parsed_asteroids_data.map do |asteroid|
      asteroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    end.max { |a,b| a<=> b}
  end

  private

  def self.asteroids_list_data_service(date)
    Faraday.new( url: 'https://api.nasa.gov',
                params: { start_date: date, api_key: ENV['nasa_api_key']}
                ).get('/neo/rest/v1/feed')
  end

  def self.parsed_asteroids_data(asteroids_list_data, date)
    JSON.parse(asteroids_list_data.body, symbolize_names: true)[:near_earth_objects][:"#{date}"]
  end

  def self.formatted_asteroid_data(parsed_asteroids_data)
    parsed_asteroids_data.map do |asteroid|
      {
        name: asteroid[:name],
        diameter: "#{asteroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{asteroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end
  end
end
