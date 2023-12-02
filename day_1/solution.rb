module Day1
  class Solution
    def self.part_1(path)
      Trebuchet.new(path).calibration_sum
    end

    def self.part_2(path)
      Trebuchet.new(path).calibration_english_sum
    end
  end

  class Trebuchet
    def initialize(path)
      @path = path
    end

    def calibration_sum
      lines.inject(0) do |sum, line|
        sum += calibrate(Day1::LineParser, line)
      end
    end

    def calibration_english_sum
      lines.inject(0) do |sum, line|
        sum += calibrate(Day1::LineParserWithWords, line)
      end
    end

    private

    def calibrate(line_parser_klass, line)
      parser = line_parser_klass.new(line)
      [parser.first, parser.last].join("").to_i
    end

    def lines
      @_lines ||= File.readlines(@path)
    end
  end

  class LineParser
    def initialize(line)
      @line = line
    end

    def first
      numbers.first
    end

    def last
      numbers.last
    end

    private

    def numbers
      @_numbers ||= @line.scan(/\d/)
    end
  end

  class LineParserWithWords
    NUMBERS = {
      "one" => 1,
      "two" => 2,
      "three" => 3,
      "four" => 4,
      "five" => 5,
      "six" => 6,
      "seven" => 7,
      "eight" => 8,
      "nine" => 9
    }.freeze

    NUMBERS_REGEX = /\d/
    WORDS_REGEX = /(?=(one|two|three|four|five|six|seven|eight|nine))/

    def initialize(line)
      @line = line
    end

    def first
      first_word_idx = line.index(WORDS_REGEX) || 50
      first_num_idx = line.index(NUMBERS_REGEX) || 50

      return numbers.first if first_num_idx < first_word_idx
      NUMBERS[words.first.first]
    end

    def last
      last_word_idx = line.rindex(WORDS_REGEX) || -1
      last_num_idx = line.rindex(NUMBERS_REGEX) || -1

      return numbers.last if last_num_idx > last_word_idx
      NUMBERS[words.last.last]
    end

    private

    attr_reader :line

    def numbers
      @_numbers ||= line.scan(NUMBERS_REGEX)
    end

    def words
      @_words ||= line.scan(WORDS_REGEX)
    end
  end
end
