require_relative 'Utils/direction'

class MarsRover
  DEFAULT_WE_SIZE = 10
  DEFAULT_NS_SIZE = 10
  DEFAULT_GRID = Array.new(DEFAULT_WE_SIZE * DEFAULT_NS_SIZE, 0).freeze
  TURN_LEFT_COMMAND = 'L'.freeze
  TURN_RIGHT_COMMAND = 'R'.freeze
  MOVE_COMMAND = 'M'.freeze
  KNOWN_COMMANDS = [TURN_LEFT_COMMAND, TURN_RIGHT_COMMAND, MOVE_COMMAND].freeze

  def initialize(position_we: 0, position_ns: 0, direction: Direction::NORTH, grid: DEFAULT_GRID)
    @position_we = position_we
    @position_ns = position_ns
    @direction = direction
    @grid = grid
  end

  def move(commands = '')
    position = { position_we: @position_we, position_ns: @position_ns, direction: @direction }
    commands = commands.upcase.split('')

    commands.each do |command|
      next_position = next_position(position, command)
      normalized_position = normalize_position(next_position)
      obstacle = check_grid_point(@grid, normalized_position)
      return "#{obstacle}, " + format_position(position) if obstacle

      position = normalized_position
    end

    format_position(position)
  end

  private

  def next_position(initial_position, command)
    raise ArgumentError, "I don't know this command \"#{command}\"" unless
      KNOWN_COMMANDS.include?(command)

    position_we = initial_position[:position_we]
    position_ns = initial_position[:position_ns]
    direction = initial_position[:direction]

    direction = Direction.turn_left(direction) if command == TURN_LEFT_COMMAND
    direction = Direction.turn_right(direction) if command == TURN_RIGHT_COMMAND
    position_we += 1 if direction == Direction::EAST && command == MOVE_COMMAND
    position_we -= 1 if direction == Direction::WEST && command == MOVE_COMMAND
    position_ns -= 1 if direction == Direction::NORTH && command == MOVE_COMMAND
    position_ns += 1 if direction == Direction::SOUTH && command == MOVE_COMMAND

    { position_we: position_we, position_ns: position_ns, direction: direction }
  end

  def normalize_position(position)
    position_we = position[:position_we] % DEFAULT_WE_SIZE
    position_ns = position[:position_ns] % DEFAULT_NS_SIZE

    { position_we: position_we, position_ns: position_ns, direction: position[:direction] }
  end

  def check_grid_point(grid, position)
    index = position[:position_we] + position[:position_ns] * 10
    return if grid[index] == 0

    grid[index]
  end

  def format_position(position)
    "#{position[:position_we]}, #{position[:position_ns]}, #{position[:direction]}"
  end
end