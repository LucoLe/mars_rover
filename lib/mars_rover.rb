require './lib/utils/direction'

class MarsRover
  DIMENSION = 10

  def initialize(x: 0, y: 0, direction: Direction::NORTH, obstacles_position: [])
    @x = x
    @y = y
    @direction = direction
    @grid = Array.new(DIMENSION * DIMENSION, 0)
    obstacles_position.map { |index| @grid[index] = 'O' }
  end

  def execute(commands = '')
    commands.split('').each do |command|
      normalized_position = normalize_position(next_position(command))
      obstacle = check_grid_point(normalized_position)
      return "#{obstacle}, " + format_position if obstacle

      change_position(normalized_position)
    end

    format_position
  end

   private

  def next_position(command)
    case command
    when 'L'
      { x: @x, y: @y, direction: Direction.turn_left(@direction) }
    when 'R'
      { x: @x, y: @y, direction: Direction.turn_right(@direction) }
    else
      case @direction
      when Direction::EAST
        { x: @x + 1, y: @y, direction: @direction }
      when Direction::WEST
        { x: @x - 1, y: @y, direction: @direction }
      when Direction::NORTH
        { x: @x, y: @y - 1, direction: @direction }
      else
        { x: @x, y: @y + 1, direction: @direction }
      end
    end
  end

  def normalize_position(position)
    { x: position[:x] % DIMENSION, y: position[:y] % DIMENSION, direction: position[:direction] }
  end

  def check_grid_point(position)
    index = position[:x] + position[:y] * DIMENSION
    return if @grid[index] == 0

    @grid[index]
  end

  def change_position(new_position)
    @x = new_position[:x]
    @y = new_position[:y]
    @direction = new_position[:direction]
  end

  def format_position
    "#{@x}, #{@y}, #{@direction}"
  end
end
