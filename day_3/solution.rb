module Day3
  class Solution
    def self.part_1(path)
      Gondola.new(path).parts_sum
    end

    def self.part_2(path)
    end
  end

  class Gondola
    def initialize(path)
      @path = path
    end

    def parts_sum
      part_numbers_values.sum
    end

    private

    attr_reader :path

    def grid
      @_grid ||= begin
        lines.map do |line|
          line.chomp.split("")
        end
      end
    end

    def all_numbers
      @_all_numbers ||= begin
        lines.flat_map.with_index do |line, y|
          res = []
          line.scan(/\d+/) do |c|
            res << [c, $~.offset(0)[0]]
          end

          res.map do |r|
            PotentialPartNumber.new(r[0], r[1], y, grid)
          end
        end
      end
    end

    def part_numbers
      @_part_numbers ||= begin
        all_numbers.select do |potential_part_number|
          potential_part_number.is_part_number?
        end
      end
    end

    def part_numbers_values
      @_part_numbers_values ||= part_numbers.map(&:value)
    end

    def lines
      @_lines ||= File.readlines(path)
    end
  end

  class PotentialPartNumber
    SYM = /(?=[^\d])(?=[^.])/
    attr_reader :value

    def initialize(value, x, y, grid)
      @length = value.length
      @value = value.to_i
      @x = x
      @y = y
      @grid = grid
    end

    def is_part_number?
      has_adjacent_symbol?
    end

    private

    attr_reader :length, :x, :y, :grid

    def has_adjacent_symbol?
      adjacent_vertically_to_symbol? ||
        adjacent_horizontally_to_symbol? ||
        adjacent_diagonally_to_symbol?
    end

    def adjacent_diagonally_to_symbol?
      down_and_to_the_left = grid[y + 1] && SYM.match(grid[y + 1][x_values.first - 1])
      down_and_to_the_right = grid[y + 1] && SYM.match(grid[y + 1][x_values.last + 1])
      up_and_to_the_left = grid[y - 1] && SYM.match(grid[y - 1][x_values.first - 1])
      up_and_to_the_right = grid[y - 1] && SYM.match(grid[y - 1][x_values.last + 1])

      up_and_to_the_left || up_and_to_the_right || down_and_to_the_left || down_and_to_the_right
    end

    def adjacent_vertically_to_symbol?
      x_values.any? do |x_value|
        (grid[y + 1] && SYM.match(grid[y + 1][x_value])) || (grid[y - 1] && SYM.match(grid[y - 1][x_value]))
      end
    end

    def adjacent_horizontally_to_symbol?
      SYM.match(grid[y][x_values.first - 1]) || SYM.match(grid[y][x_values.last + 1])
    end

    def x_values
      @_x_values ||= begin
        values = [x]
        while values.length < length
          values << values.last + 1
        end
        values
      end
    end
  end
end
