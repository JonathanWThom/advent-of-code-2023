require "minitest/autorun"
require_relative "solution"

class Day3::SolutionTest < Minitest::Test
  def test_part_1_sample
    assert_equal(4361, Day3::Solution.part_1("day_3/input_sample.txt"))
  end

  def test_part_1_full
    # too low
    assert_equal(516054, Day3::Solution.part_1("day_3/input.txt"))
  end

  #def test_part_2_sample
    #assert_equal(2286, Day3::Solution.part_2("day_3/input_sample.txt"))
  #end

  #def test_part_2_full
    #assert_equal(71220, Day3::Solution.part_2("day_3/input.txt"))
  #end
end
