require 'minitest/autorun'
require_relative '../../../Lib/Utils/grid_builder'

describe GridBuilder do
  it "has some meaningful defaluts" do
    grid = GridBuilder.new().grid
    assert_equal grid, Array.new(GridBuilder::DEFAULT_NS_SIZE * GridBuilder::DEFAULT_WE_SIZE, GridBuilder::DEFAULT_TERRAIN_SYMBOL)
  end

  it "accepts grid parameters" do
    grid = GridBuilder.new(we_size: 5, ns_size: 5, terrain_symbol: 'V', obstacle_symbol: 8, obstacles_position: [1, 5, 12, 24]).grid
    expectation = [
      'V', 8, 'V', 'V', 'V',
      8, 'V', 'V', 'V', 'V',
      'V', 'V', 8, 'V', 'V',
      'V', 'V', 'V', 'V', 'V',
      'V', 'V', 'V', 'V', 8
    ]

    assert_equal grid, expectation
  end

  it "returns we_size" do
    grid = GridBuilder.new(we_size: 5)
    assert_equal grid.we_size, 5
  end

  it "returns ns_size" do
    grid = GridBuilder.new(ns_size: 5)
    assert_equal grid.ns_size, 5
  end

  it "returns terrain_symbol" do
    grid = GridBuilder.new(terrain_symbol: 'V')
    assert_equal grid.terrain_symbol, 'V'
  end

  it "returns obstacle_symbol" do
    grid = GridBuilder.new(obstacle_symbol: 8)
    assert_equal grid.obstacle_symbol, 8
  end
end