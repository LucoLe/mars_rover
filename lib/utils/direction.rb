class Direction
  NORTH = 'N'
  EAST = 'E'
  SOUTH = 'S'
  WEST = 'W'

  def self.turn_left(initial_direction)
    return WEST if initial_direction == NORTH
    return SOUTH if initial_direction == WEST
    return EAST if initial_direction == SOUTH

    NORTH
  end

  def self.turn_right(initial_direction)
    return EAST if initial_direction == NORTH
    return SOUTH if initial_direction == EAST
    return WEST if initial_direction == SOUTH

    NORTH
  end
end