require_relative 'near_earth_objects'
require_relative 'table'

puts "________________________________________________________________________________________________________________________________"
puts "Welcome to NEO. Here you will find information about how many meteors, asteroids, comets pass by the earth every day. \nEnter a date below to get a list of the objects that have passed by the earth on that day."
puts "Please enter a date in the following format YYYY-MM-DD."
print ">>"

date = gets.chomp
asteroid_details = NearEarthObjects.find_neos_by_date(date)
total_number_of_asteroids = asteroid_details.neos[:total_number_of_asteroids]
largest_asteroid = asteroid_details.neos[:biggest_asteroid]

table = Table.new(asteroid_details)
formated_date = DateTime.parse(date).strftime("%A %b %d, %Y")
puts "______________________________________________________________________________"
puts "On #{formated_date}, there were #{total_number_of_asteroids} objects that almost collided with the earth."
puts "The largest of these was #{largest_asteroid} ft. in diameter."
puts "\nHere is a list of objects with details:"
puts table.make_whole_table
