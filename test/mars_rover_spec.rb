require 'minitest/autorun'
require './lib/mars_rover'

#    Grid with obstacles
# 0, 0, 0, 0, 0, 0, 0, 0, 0, O,
# 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
# 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
# 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
# 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
# 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
# 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
# 0, X, 0, 0, 0, 0, 0, 0, 0, 0,
# 0, 0, O, 0, 0, 0, 0, 0, 0, 0,
# 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

Point = Struct.new(:x, :y, :direction)
Obstacle = Struct.new(:x, :y, :symbol)
Grid = Struct.new(:size, :obstacles)

describe MarsRover do
  let(:mars_rover) { MarsRover.new(@starting_point, @grid) }

  describe "move on a grid without obstacles" do
    before do
      @starting_point = Point.new(0, 0, 'N')
      @grid = Grid.new(10)
    end

    it "returns starting point when commands are an empty string" do
      mars_rover.execute('').must_equal '0, 0, N'
    end

    it "executes a set of commands" do
      mars_rover.execute('RMMLM').must_equal '2, 1, N'
    end

    it "wraps around going in east direction" do
      @starting_point = Point.new(9, 0, 'E')
      mars_rover.execute('M').must_equal '0, 0, E'
    end

    it "wraps around going in west direction" do
      @starting_point = Point.new(0, 0, 'W')
      mars_rover.execute('M').must_equal '9, 0, W'
    end

    it "wraps around going in north direction" do
      @starting_point = Point.new(0, 0, 'S')
      mars_rover.execute('M').must_equal '0, 9, S'
    end

    it "wraps around going in south direction" do
      @starting_point = Point.new(0, 9, 'N')
      mars_rover.execute('M').must_equal '0, 0, N'
    end
  end

  describe "move on a grid with obstacles" do
    obstacles = [
      Obstacle.new(2, 1, 'O'),
      Obstacle.new(1, 2, 'X'),
      Obstacle.new(9, 9, 'O')
    ]

    before do
      @starting_point = Point.new(0, 0, 'N')
      @grid = Grid.new(10, obstacles)
    end

    it "reports last possible point and obstacle" do
      @starting_point = Point.new(2, 0, 'N')
      mars_rover.execute('M').must_equal 'O, 2, 0, N'
    end

    it "ignores the commands after the obstacle" do
      @starting_point = Point.new(2, 0, 'N')
      mars_rover.execute('MRM').must_equal 'O, 2, 0, N'
    end

    it "reads the obstacle symbol from the grid" do
      @starting_point = Point.new(0, 2, 'E')
      mars_rover.execute('M').must_equal 'X, 0, 2, E'
    end

    it "executes a set of commands" do
      @starting_point = Point.new(0, 0, 'S')
      mars_rover.execute('MRM').must_equal 'O, 0, 9, W'
    end
  end
end
