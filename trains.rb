#!/usr/bin/env ruby

class Route
  def initialize(parts)
    @parts = parts.split("")
  end

  def start
    @parts.first
  end

  def terminus
    @parts.last
  end
end

class Graph
  def initialize
    @verticies = {}
  end

  def distance(route)
    # returns the distance of the route
  end

  def trips(a, b)
    # returns all of the trips between A and B
  end
end

class Vertex

end

class Edge
  attr_accessor :route, :distance

  def self.from_string(input)
    re = /(?<route>[A-Z]+)(?<distance>\d+)/
    self.new re.match(input).named_captures
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

  def to_s
    [start, terminus, distance].join
  end
end


if __FILE__ == $0
  STDIN.read.split(",").each do |input|
    # each line is a (Start, End, Distance)
    edge = Edge.from_string(input)
    puts edge.distance
  end
end
