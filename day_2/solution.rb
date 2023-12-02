module Day2
  class Solution
    def self.part_1(path)
      SnowIsland.new(path).possible_game_sum
    end

    def self.part_2(path)
      SnowIslandWater.new(path).fewest_cubes_power
    end
  end

  module HasGames
    # todo
  end

  class SnowIslandWater
    def initialize(path)
      @path = path
    end

    def fewest_cubes_power
      game_powers.sum
    end

    private

    def lines
      @_lines ||= File.readlines(@path)
    end

    def game_powers
      games.map(&:cube_power)
    end

    def games
      @_games ||= lines.map { |line| Game.new(line) }
    end
  end

  class SnowIsland
    def initialize(path)
      @path = path
    end

    def possible_game_sum
      possible_game_ids.sum
    end

    private

    def lines
      @_lines ||= File.readlines(@path)
    end

    def games
      @_games ||= lines.map { |line| Game.new(line) }
    end

    def possible_game_ids
      games.reject { |game| game.impossible? }.map(&:id)
    end
  end

  class Game
    def initialize(line)
      @line = line
    end

    def id
      line.scan(/\d+/).first.to_i
    end

    def impossible?
      draws.any? { |draw| draw.impossible? }
    end

    def cube_power
      max_red = 0
      max_green = 0
      max_blue = 0

      draws.each do |draw|
        if draw.max_red > max_red
          max_red = draw.max_red
        end

        if draw.max_green > max_green
          max_green = draw.max_green
        end

        if draw.max_blue > max_blue
          max_blue = draw.max_blue
        end
      end

      max_red * max_green * max_blue
    end

    private

    attr_reader :line

    def draws
      line.gsub("Game #{id}: ", "").split("; ").map { |d| Draw.new(d) }
    end
  end

  class Draw
    RED_LIMIT = 12
    GREEN_LIMIT = 13
    BLUE_LIMIT = 14

    def initialize(draw)
      @draw = draw
    end

    def impossible?
      red_over? || blue_over? || green_over?
    end

    def max_red
      all_red.max || 0
    end

    def max_green
      all_green.max || 0
    end

    def max_blue
      all_blue.max || 0
    end

    private

    attr_reader :draw

    def cubes
      @_cubes ||= @draw.split(", ")
    end

    def all_red
      @_all_red ||= all_of_color("red")
    end

    def all_green
      @_all_green ||= all_of_color("green")
    end

    def all_blue
      @_all_blue ||= all_of_color("blue")
    end

    def red
      first_of_color("red")
    end

    def red_over?
      red > RED_LIMIT
    end

    def blue
      first_of_color("blue")
    end

    def blue_over?
      blue > BLUE_LIMIT
    end

    def green
      first_of_color("green")
    end

    def green_over?
      green > GREEN_LIMIT
    end

    def all_of_color(color)
      cubes.select do |cube|
        Regexp.new(color).match(cube)
      end.map do |cube|
        cube.scan(/\d+/).first.to_i
      end
    end

    def first_of_color(color)
      cubes.detect do |cube|
        Regexp.new(color).match(cube)
      end&.scan(/\d+/)&.first&.to_i || 0
    end
  end
end
