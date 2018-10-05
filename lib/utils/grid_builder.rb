class GridBuilder
  DEFAULT_WE_SIZE = 10
  DEFAULT_NS_SIZE = 10
  DEFAULT_TERRAIN_SYMBOL = 0
  DEFAULT_OBSTACLE_SYMBOL = 'X'.freeze

  attr_reader :grid, :we_size, :ns_size, :terrain_symbol, :obstacle_symbol

  def initialize(
    we_size: DEFAULT_WE_SIZE,
    ns_size: DEFAULT_NS_SIZE,
    terrain_symbol: DEFAULT_TERRAIN_SYMBOL,
    obstacle_symbol: DEFAULT_OBSTACLE_SYMBOL,
    obstacles_position: []
  )
    @we_size = we_size
    @ns_size = ns_size
    @terrain_symbol = terrain_symbol
    @obstacle_symbol = obstacle_symbol
    @grid = Array.new(@we_size * @ns_size, @terrain_symbol)
    obstacles_position.map { |index| @grid[index] = @obstacle_symbol }
  end
end