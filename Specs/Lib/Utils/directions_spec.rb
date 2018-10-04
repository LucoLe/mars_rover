require 'minitest/autorun'
require_relative '../../../Lib/Utils/direction'

describe Direction do
  describe "turn_left" do
    it "turns to the next cardinal direction anti clockwise" do
      assert_equal Direction.turn_left(Direction::NORTH), Direction::WEST
      assert_equal Direction.turn_left(Direction::WEST), Direction::SOUTH
      assert_equal Direction.turn_left(Direction::SOUTH), Direction::EAST
      assert_equal Direction.turn_left(Direction::EAST), Direction::NORTH
    end

    it "understands lower case" do
      assert_equal Direction.turn_left('n'), Direction::WEST
    end

    it "raises an ArgumentError when the initial direction is not known" do
      exception = assert_raises ArgumentError do
        Direction.turn_left('G')
      end
      assert_equal exception.message, 'That\'s not a valid direction "G"'
    end
  end

  describe "turn_right" do
    it "turns to the next cardinal direction clockwise" do
      assert_equal Direction.turn_right(Direction::NORTH), Direction::EAST
      assert_equal Direction.turn_right(Direction::EAST), Direction::SOUTH
      assert_equal Direction.turn_right(Direction::SOUTH), Direction::WEST
      assert_equal Direction.turn_right(Direction::WEST), Direction::NORTH
    end

    it "understands lower case" do
      assert_equal Direction.turn_right('n'), Direction::EAST
    end

    it "raises an ArgumentError when the initial direction is not known" do
      exception = assert_raises ArgumentError do
        Direction.turn_right('G')
      end
      assert_equal exception.message, 'That\'s not a valid direction "G"'
    end
  end
end
