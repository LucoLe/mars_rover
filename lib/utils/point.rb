require './lib/utils/direction'

class Point
  def initialize(coordinates = { position_we: 0, position_ns: 0, direction: Direction::NORTH }, obstacle = nil)
    @position_we = coordinates[:position_we]
    @position_ns = coordinates[:position_ns]
    @direction = coordinates[:direction]
    @obstacle = obstacle
  end

  def to_s
    formated_position = "#{@position_we}, #{@position_ns}, #{@direction}"
    return "#{@obstacle}, " + formated_position if @obstacle

    formated_position
  end

  def coordinates
    { position_we: @position_we, position_ns: @position_ns, direction: @direction }
  end
end