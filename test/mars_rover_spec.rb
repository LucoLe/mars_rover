require 'minitest/autorun'
require './lib/mars_rover'

#    Grid with obstacles
# 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
# 0, 0, 'O', 0, 0, 0, 0, 0, 0, 0,
# 0, 'O', 0, 0, 0, 0, 0, 0, 0, 0,
# 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
# 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
# 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
# 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
# 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
# 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
# 0, 'O', 0, 0, 0, 0, 0, 0, 0, 'O'

OBSTACLES_POSITION = [12, 21, 91, 99]

describe MarsRover do
  describe "move on a grid without obstacles" do
    before do
      @mars_rover = MarsRover.new
    end

    it "returns default values when invoked without value" do
      assert_equal @mars_rover.execute, '0, 0, N'
    end

    it "accepts initial position of the rover" do
      @mars_rover = MarsRover.new(x: 5, y: 2, direction: Direction::SOUTH)
      assert_equal @mars_rover.execute, '5, 2, S'
    end

    it "wraps around going in east direction" do
      commands = 'R' + 'M' * 13
      assert_equal @mars_rover.execute(commands), '3, 0, E'
    end

    it "wraps around going in west direction" do
      commands = 'L' + 'M' * 13
      assert_equal @mars_rover.execute(commands), '7, 0, W'
    end

    it "wraps around going in north direction" do
      commands = 'M' * 13
      assert_equal @mars_rover.execute(commands), '0, 7, N'
    end

    it "wraps around going in south direction" do
      commands = 'LL' + 'M' * 13
      assert_equal @mars_rover.execute(commands), '0, 3, S'
    end
  end

  describe "move on a grid with obstacles" do
    before do
      @mars_rover = MarsRover.new(obstacles_position: OBSTACLES_POSITION)
    end

    it "reports last possible point and obstacle" do
      assert_equal @mars_rover.execute('RMMRM'), 'O, 2, 0, S'

      @mars_rover = MarsRover.new(obstacles_position: OBSTACLES_POSITION)
      assert_equal @mars_rover.execute('RRMLMM'), 'O, 1, 1, E'

      # The commands after the obstacle are ignored
      @mars_rover = MarsRover.new(obstacles_position: OBSTACLES_POSITION)
      assert_equal @mars_rover.execute('RRMLMMM'), 'O, 1, 1, E'

      @mars_rover = MarsRover.new(obstacles_position: OBSTACLES_POSITION)
      assert_equal @mars_rover.execute('RMRMM'), 'O, 1, 1, S'

      @mars_rover = MarsRover.new(obstacles_position: OBSTACLES_POSITION)
      assert_equal @mars_rover.execute('MRM'), 'O, 0, 9, E'

      @mars_rover = MarsRover.new(obstacles_position: OBSTACLES_POSITION)
      assert_equal @mars_rover.execute('MLM'), 'O, 0, 9, W'
    end
  end
end
