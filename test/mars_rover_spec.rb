require 'minitest/autorun'
require './lib/mars_rover'

#              Grid with obstacles
#  'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V',
#  'V', 'V', 'Z', 'V', 'V', 'V', 'V', 'V', 'V', 'V',
#  'V', 'Z', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V',
#  'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V',
#  'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V',
#  'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V',
#  'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V',
#  'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V',
#  'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'V',
#  'V', 'Z', 'V', 'V', 'V', 'V', 'V', 'V', 'V', 'Z'

GRID_WITH_OBSTACLES = GridBuilder.new(terrain_symbol: 'V', obstacle_symbol: 'Z', obstacles_position: [12, 21, 91, 99]).freeze

# Grid of different size
#  0, 0, 0, 0, 0, 0, 0,
#  0, 0, 0, X, 0, 0, 0,
#  0, X, 0, 0, 0, 0, 0,
#  0, 0, 0, 0, 0, 0, 0

GRID_WITH_OBSTACLES_DIFFERENT_SIZE = GridBuilder.new(we_size: 7, ns_size: 4, obstacles_position: [10, 15]).freeze

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
      @mars_rover = MarsRover.new(grid_builder: GRID_WITH_OBSTACLES)
    end

    it "reports last possible point and obstacle" do
      assert_equal @mars_rover.move('RMMRM'), "Z, 2, 0, #{Direction::SOUTH}"

      @mars_rover = MarsRover.new(grid_builder: GRID_WITH_OBSTACLES)
      assert_equal @mars_rover.move('RRMLMM'), "Z, 1, 1, #{Direction::EAST}"
      # The commands after the obstacle are ignored
      @mars_rover = MarsRover.new(grid_builder: GRID_WITH_OBSTACLES)
      assert_equal @mars_rover.move('RRMLMMM'), "Z, 1, 1, #{Direction::EAST}"

      @mars_rover = MarsRover.new(grid_builder: GRID_WITH_OBSTACLES)
      assert_equal @mars_rover.move('RMRMM'), "Z, 1, 1, #{Direction::SOUTH}"

      @mars_rover = MarsRover.new(grid_builder: GRID_WITH_OBSTACLES)
      assert_equal @mars_rover.move('MRM'), "Z, 0, 9, #{Direction::EAST}"

      @mars_rover = MarsRover.new(grid_builder: GRID_WITH_OBSTACLES)
      assert_equal @mars_rover.move('MLM'), "Z, 0, 9, #{Direction::WEST}"
    end

    it "works with grid of different size" do
      @mars_rover = MarsRover.new(grid_builder: GRID_WITH_OBSTACLES_DIFFERENT_SIZE)
      assert_equal @mars_rover.move('MMRMM'), "X, 0, 2, #{Direction::EAST}"

      @mars_rover = MarsRover.new(grid_builder: GRID_WITH_OBSTACLES_DIFFERENT_SIZE)
      assert_equal @mars_rover.move('LLMRMMMM'), "X, 4, 1, #{Direction::WEST}"
    end
  end
end