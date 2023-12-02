require "minitest/autorun"
require_relative "solution"

class Day1::SolutionTest < Minitest::Test
  def test_part_1_sample
    assert_equal(142, Day1::Solution.part_1("day_1/input_sample.txt"))
  end

  def test_part_1_full
    assert_equal(54304, Day1::Solution.part_1("day_1/input.txt"))
  end

  def test_part_2_sample
    assert_equal(281, Day1::Solution.part_2("day_1/input_sample_part_2.txt"))
  end

  def test_part_2_full
    assert_equal(54418, Day1::Solution.part_2("day_1/input.txt"))
  end
end
