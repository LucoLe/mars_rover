require 'minitest/autorun'
require './lib/utils/direction'

describe Direction do
  describe "turn_left" do
    it "turns to the next cardinal direction anti clockwise" do
      assert_equal Direction.turn_left(Direction::NORTH), 'W'
      assert_equal Direction.turn_left(Direction::WEST), 'S'
      assert_equal Direction.turn_left(Direction::SOUTH), 'E'
      assert_equal Direction.turn_left(Direction::EAST), 'N'
    end
  end

  describe "turn_right" do
    it "turns to the next cardinal direction clockwise" do
      assert_equal Direction.turn_right(Direction::NORTH), 'E'
      assert_equal Direction.turn_right(Direction::EAST), 'S'
      assert_equal Direction.turn_right(Direction::SOUTH), 'W'
      assert_equal Direction.turn_right(Direction::WEST), 'N'
    end
  end
end
