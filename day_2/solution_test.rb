require "minitest/autorun"
require_relative "solution"

class Day2::SolutionTest < Minitest::Test
  def test_part_1_sample
    assert_equal(8, Day2::Solution.part_1("day_2/input_sample.txt"))
  end

  def test_part_1_full
    assert_equal(54304, Day2::Solution.part_1("day_2/input.txt"))
  end

  #def test_part_2_sample
    #assert_equal(281, Day2::Solution.part_2("day_2/input_sample.txt"))
  #end

  #def test_part_2_full
    #assert_equal(54418, Day2::Solution.part_2("day_2/input.txt"))
  #end
end
