require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'table'
require_relative 'near_earth_objects'

class TableTest < Minitest::Test
  def setup
    astroid_details = NearEarthObjects.find_neos_by_date('2019-03-30')
    @table = Table.new(astroid_details)
  end

  def test_it_exists
    assert_instance_of Table, @table
  end

  def test_it_can_get_column_data
    expected = {:name=>{:label=>"Name", :width=>17},
                :diameter=>{:label=>"Diameter", :width=>8},
                :miss_distance=>{:label=>"Missed The Earth By:", :width=>20}}

    assert_equal expected, @table.column_data
  end

  def test_it_can_get_header
     expected = "| Name              | Diameter | Missed The Earth By: |"
     assert_equal expected, @table.header
  end

   def test_it_can_get_divider
     expected = "+-------------------+----------+----------------------+"
     assert_equal expected, @table.divider
   end

   def test_it_can_create_rows
    astroid_details = NearEarthObjects.find_neos_by_date('2019-03-30')
    table = Table.new(astroid_details)
    row_one_data = {:name=>"(2019 GD4)", :diameter=>"61 ft", :miss_distance=>"911947 miles"}
    assert_equal row_one_data, table.create_rows[0]
   end

end
