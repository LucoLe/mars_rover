class Direction
  NORTH = 'N'.freeze
  EAST = 'E'.freeze
  SOUTH = 'S'.freeze
  WEST = 'W'.freeze
  CARDINAL_DIRECTIONS = [NORTH, EAST, SOUTH, WEST].freeze

  def self.turn_left(initial_direction)
    initial_direction = initial_direction.upcase

    raise ArgumentError, "That's not a valid direction \"#{initial_direction}\"" unless
      CARDINAL_DIRECTIONS.include?(initial_direction)
    return WEST if initial_direction == NORTH
    return SOUTH if initial_direction == WEST
    return EAST if initial_direction == SOUTH

    NORTH
  end

  def self.turn_right(initial_direction)
    initial_direction = initial_direction.upcase

    raise ArgumentError, "That's not a valid direction \"#{initial_direction}\"" unless
      CARDINAL_DIRECTIONS.include?(initial_direction)
    return EAST if initial_direction == NORTH
    return SOUTH if initial_direction == EAST
    return WEST if initial_direction == SOUTH

    NORTH
  end
end