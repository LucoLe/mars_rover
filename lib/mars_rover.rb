
class MarsRover
  def initialize(starting_point, grid)
    @directions = %w[N E S W]
    @point = starting_point
    @grid = grid
  end

  def execute(commands)
    commands.split('').each do |command|
      turn_left if command == 'L'
      turn_right if command == 'R'
      next unless command == 'M'

      next_coordinates = next_coordinates()
      obstacle = check_for_obstacle(next_coordinates[:x], next_coordinates[:y])
      return "#{obstacle.symbol}, " + format_point if obstacle

      @point.x = next_coordinates[:x]
      @point.y = next_coordinates[:y]
    end

    format_point
  end

  private

  def turn_left
    @point.direction = @directions[@directions.index(@point.direction) - 1]
  end

  def turn_right
    @point.direction = @directions[(@directions.index(@point.direction) + 1) % 4]
  end

  def next_coordinates
    x = @point.x
    y = @point.y

    case @point.direction
    when 'E'
      x += 1
    when 'W'
      x -= 1
    when 'N'
      y += 1
    else
      y -= 1
    end

    { x: x % @grid.size, y: y % @grid.size }
  end

  def check_for_obstacle(x, y)
    return unless @grid.obstacles

    @grid.obstacles.find do |obstacle|
      x == obstacle.x && y == obstacle.y
    end
  end

  def format_point
    "#{@point.x}, #{@point.y}, #{@point.direction}"
  end
end
