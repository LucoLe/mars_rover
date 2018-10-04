require_relative '../Utils/point'
require_relative '../Utils/direction'

class Driver
  DEFAULT_STEP_SIZE = 1
  TURN_LEFT_COMMAND = 'L'.freeze
  TURN_RIGHT_COMMAND = 'R'.freeze
  MOVE_COMMAND = 'M'.freeze
  KNOWN_COMMANDS = [TURN_LEFT_COMMAND, TURN_RIGHT_COMMAND, MOVE_COMMAND].freeze

  def initialize(step_size: DEFAULT_STEP_SIZE)
    @step_size = step_size
  end

  def next_point(point, command)
    command = command.upcase

    raise ArgumentError, "I don't know this command \"#{command}\"" unless
      KNOWN_COMMANDS.include?(command)

    initial_position = point.coordinates
    position_we = initial_position[:position_we]
    position_ns = initial_position[:position_ns]
    direction = initial_position[:direction]

    direction = Direction.turn_left(direction) if command == TURN_LEFT_COMMAND
    direction = Direction.turn_right(direction) if command == TURN_RIGHT_COMMAND
    position_we += @step_size if direction == Direction::EAST && command == MOVE_COMMAND
    position_we -= @step_size if direction == Direction::WEST && command == MOVE_COMMAND
    position_ns -= @step_size if direction == Direction::NORTH && command == MOVE_COMMAND
    position_ns += @step_size if direction == Direction::SOUTH && command == MOVE_COMMAND

    Point.new(position_we: position_we, position_ns: position_ns, direction: direction)
  end
end