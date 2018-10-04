require 'minitest/autorun'
require_relative '../../../Lib/Utils/point'

describe Direction do
  it "returns properly formated coordinates when there is no obstacle" do
    point = Point.new(position_we: 4, position_ns: 3, direction: Direction::WEST)
    assert_equal point.to_s, "4, 3, #{Direction::WEST}"
  end

  it "returns properly formated coordinates when there is an obstacle" do
    point = Point.new({ position_we: 4, position_ns: 3, direction: Direction::WEST }, 3)
    assert_equal point.to_s, "3, 4, 3, #{Direction::WEST}"

    point = Point.new({ position_we: 4, position_ns: 3, direction: Direction::WEST }, "X")
    assert_equal point.to_s, "X, 4, 3, #{Direction::WEST}"
  end

  it "coordinates returns a hash with the coordinates" do
    point = Point.new(position_we: 4, position_ns: 3, direction: Direction::WEST)
    assert_equal point.coordinates[:position_we], 4
    assert_equal point.coordinates[:position_ns], 3
    assert_equal point.coordinates[:direction], Direction::WEST
  end
end