require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'table'
require_relative 'near_earth_objects'
class TableTest < Minitest::Test
  def test_it_exists
    astroid_details = NearEarthObjects.find_neos_by_date('2019-03-30')
    table = Table.new(astroid_details)
    assert_instance_of Table, table
  end

end
