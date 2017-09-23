#!/usr/bin/env ruby

class Graph
  def initialize

  end
end

class Vertex

end

class Edge
  attr_accessor :a, :b, :distance

  def self.from_string(input)
    re = /(?<a>[A-Z])(?<b>[A-Z])(?<distance>\d+)/
    self.new re.match(input).named_captures
  end

  def initialize(parameters)
    @a = parameters['a']
    @b = parameters['b']
    @distance = parameters['distance'].to_i
  end

  def to_s
    [@a, @b, @distance].join
  end
end


STDIN.read.split(",").each do |input|
  # each line is a (Start, End, Distance)
  edge = Edge.from_string(input)
  puts edge.distance
end
