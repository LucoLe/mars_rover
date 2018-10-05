require 'minitest/autorun'
require './lib/mars_rover'

GRID_WITH_OBSTACLES = [
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
  0, 2, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 3, 0, 0, 0, 0, 0, 0, 0, 'X'
]

describe MarsRover do
  describe "move on a grid without obstacles" do
    before do
      @mars_rover = MarsRover.new
    end

    it "returns default values when invoked without value" do
      assert_equal @mars_rover.move, "0, 0, #{Direction::NORTH}"
    end

    it "accepts initial position of the rover" do
      @mars_rover = MarsRover.new(position_we: 5, position_ns: 2, direction: Direction::SOUTH)
      assert_equal @mars_rover.move, "5, 2, #{Direction::SOUTH}"
    end

    it "raises an ArgumentError when the command is not known" do
      exception = assert_raises ArgumentError do
        @mars_rover.move('LMF')
      end
      assert_equal exception.message, 'I don\'t know this command "F"'
    end

    it "accepts commands both in lower and upper case" do
      assert_equal @mars_rover.move('RmmrM'), "2, 1, #{Direction::SOUTH}"
    end

    it "wraps around going in east direction" do
      commands = 'R' + 'M' * 13
      assert_equal @mars_rover.move(commands), "3, 0, #{Direction::EAST}"
    end

    it "wraps around going in west direction" do
      commands = 'L' + 'M' * 13
      assert_equal @mars_rover.move(commands), "7, 0, #{Direction::WEST}"
    end

    it "wraps around going in north direction" do
      commands = 'M' * 13
      assert_equal @mars_rover.move(commands), "0, 7, #{Direction::NORTH}"
    end

    it "wraps around going in south direction" do
      commands = 'LL' + 'M' * 13
      assert_equal @mars_rover.move(commands), "0, 3, #{Direction::SOUTH}"
    end
  end

  describe "move on a grid with obstacles" do
    before do
      @mars_rover = MarsRover.new(grid: GRID_WITH_OBSTACLES)
    end

    it "reports last possible point and obstacle" do
      assert_equal @mars_rover.move('RMMRM'), "1, 2, 0, #{Direction::SOUTH}"

      @mars_rover = MarsRover.new(grid: GRID_WITH_OBSTACLES)
      assert_equal @mars_rover.move('RRMLMM'), "1, 1, 1, #{Direction::EAST}"

      # The commands after the obstacle are ignored
      @mars_rover = MarsRover.new(grid: GRID_WITH_OBSTACLES)
      assert_equal @mars_rover.move('RRMLMMM'), "1, 1, 1, #{Direction::EAST}"

      @mars_rover = MarsRover.new(grid: GRID_WITH_OBSTACLES)
      assert_equal @mars_rover.move('RMRMM'), "2, 1, 1, #{Direction::SOUTH}"

      @mars_rover = MarsRover.new(grid: GRID_WITH_OBSTACLES)
      assert_equal @mars_rover.move('MRM'), "3, 0, 9, #{Direction::EAST}"

      @mars_rover = MarsRover.new(grid: GRID_WITH_OBSTACLES)
      assert_equal @mars_rover.move('MLM'), "X, 0, 9, #{Direction::WEST}"
    end
  end
end
