require './lib/utils/direction'
require './lib/utils/point'
require './lib/utils/grid_builder'
require './lib/rover/driver'

class MarsRover
  def initialize(
    position_we: 0,
    position_ns: 0,
    direction: Direction::NORTH,
    grid_builder: GridBuilder.new
  )
    @point = Point.new(position_we: position_we, position_ns: position_ns, direction: direction)
    @grid_builder = grid_builder
  end

  def move(commands = '')
    point = @point
    commands = commands.split('')

    commands.each do |command|
      next_point = Driver.new.next_point(point, command)
      normalized_point = normalize_point(@grid_builder, next_point)
      obstacle = check_grid_point(@grid_builder, normalized_point)
      return Point.new(point.coordinates, obstacle).to_s if obstacle

      point = Point.new(normalized_point.coordinates)
    end

    point.to_s
  end

  private

  def normalize_point(grid_builder, point)
    position = point.coordinates
    position_we = position[:position_we] % grid_builder.we_size
    position_ns = position[:position_ns] % grid_builder.ns_size

    Point.new(position_we: position_we, position_ns: position_ns, direction: position[:direction])
  end

  def check_grid_point(grid_builder, point)
    position = point.coordinates
    index = position[:position_we] + position[:position_ns] * grid_builder.we_size
    return if grid_builder.grid[index] == grid_builder.terrain_symbol

    grid_builder.grid[index]
  end
end