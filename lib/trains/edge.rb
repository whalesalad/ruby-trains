module Trains
  class Edge
    attr_accessor :route, :distance

    def self.from_string(input)
      re = /(?<route>[A-Z]+)(?<distance>\d+)/
      self.new re.match(input.strip).named_captures
    end

    def initialize(parameters)
      @route = Route.new(parameters['route'])
      @distance = parameters['distance'].to_i
    end

    def start
      route.start
    end

    def terminus
      route.terminus
    end

    def verticies
      return [route.start, route.terminus]
    end

    def to_s
      [start, terminus, distance].join
    end
  end
end
