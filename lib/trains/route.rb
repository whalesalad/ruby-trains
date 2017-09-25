module Trains
  class Route
    attr_accessor :parts

    def self.from_parts(*parts)
      self.new parts.join
    end

    def initialize(parts)
      @parts = parts.split("")
    end

    def start
      parts.first
    end

    def terminus
      parts.last
    end

    def segments
      parts.each_cons(2)
    end

    def max_stops?(num_stops)
      parts.size <= num_stops + 1
    end

    def exact_stops?(num_stops)
      parts.size.eql? num_stops + 1
    end

    def to_s
      parts.join
    end
  end
end
