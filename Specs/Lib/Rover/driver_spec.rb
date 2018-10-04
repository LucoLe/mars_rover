require 'minitest/autorun'
require_relative '../../../Lib/Rover/driver'

describe Driver do
  describe "next_point" do
    before do
      @driver = Driver.new
      @point = Point.new
    end

    it "raises an ArgumentError when the command is not known" do
      exception = assert_raises ArgumentError do
        @driver.next_point(@point, 'F')
      end
      assert_equal exception.message, 'I don\'t know this command "F"'
    end

    it "should return a new point" do
      assert_equal @driver.next_point(@point, 'M').is_a?(Point), true
    end

    it "accepts commands both in lower and upper case" do
      assert_equal @driver.next_point(@point, 'r').to_s, "0, 0, #{Direction::EAST}"
      assert_equal @driver.next_point(@point, 'R').to_s, "0, 0, #{Direction::EAST}"
      assert_equal @driver.next_point(@point, 'm').to_s, "0, -1, #{Direction::NORTH}"
      assert_equal @driver.next_point(@point, 'M').to_s, "0, -1, #{Direction::NORTH}"
    end

    it "accepts different step_size" do
      @driver = Driver.new(step_size: 2)
      assert_equal @driver.next_point(@point, 'M').to_s, "0, -2, #{Direction::NORTH}"
    end
  end
end