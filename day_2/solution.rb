module Day2
  class Solution
    def self.part_1(path)
      SnowIsland.new(path).possible_game_sum
    end

    def self.part_2(path)
      0
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

    private

    attr_reader :draw

    def cubes
      @_cubes ||= @draw.split(", ")
    end

    def red
      cubes.detect do |cube|
        /red/.match(cube)
      end&.scan(/\d+/)&.first&.to_i || 0
    end

    def red_over?
      red > RED_LIMIT
    end

    def blue
      cubes.detect do |cube|
        /blue/.match(cube)
      end&.scan(/\d+/)&.first&.to_i || 0
    end

    def blue_over?
      blue > BLUE_LIMIT
    end

    def green
      cubes.detect do |cube|
        /green/.match(cube)
      end&.scan(/\d+/)&.first&.to_i || 0
    end

    def green_over?
      green > GREEN_LIMIT
    end
  end
end
