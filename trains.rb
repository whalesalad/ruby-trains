#!/usr/bin/env ruby

require 'pp'

class Route
  attr_accessor :parts

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
end

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

class Vertex
  attr_accessor :edges, :graph

  def initialize(graph)
    @graph = graph
    @edges = []
  end

  def add_edge(edge)
    @edges << edge
  end

  def neighbor_names
    neighor_names = edges.map { |e| e.terminus }
  end

  def neighbors
    graph.verticies.select { |k,v| neighbor_names.include? k }
  end

  def connection_to(vertex)
    edges.detect { |e| e.terminus.eql? vertex }
  end
end

class Graph
  attr_accessor :verticies

  def self.create_from_input_string(input)
    edges = input.split(",").map { |e| Edge.from_string(e) }
    self.create_from_edges(edges)
  end

  def self.create_from_edges(edges)
    graph = self.new().tap do |g|
      edges.each { |e| g.add_edge(e) }
    end
  end

  def initialize
    @verticies = {}
  end

  def vertex_exists?(vertex)
    verticies.has_key? vertex
  end

  def get_vertex(vertex)
    verticies[vertex]
  end

  def get_or_create_vertex(vertex)
    return verticies[vertex] ||= Vertex.new(self)
  end

  def add_edge(edge)
    # 1. make sure a vertex exists for each start and terminus
    # 2. because this is an one-way graph, notify the start
    #    vertex that it has a connection to the terminus, with a distance.
    vertex = get_or_create_vertex(edge.start).tap do |v|
      v.add_edge(edge)
    end
  end

  def edges_for_route(route)
    # returns a collection of edges for a route
    edges = []

    route.segments.each do |a, b|
      # does a vertex exist at all?
      vertex = get_vertex(a)
      edge = vertex.connection_to(b)

      if not edge
        return false
      end

      edges << edge
    end

    return edges
  end

  def distance(route)
    distances = edges_for_route(route).map { |e| e.distance }.inject(:+)
  end

  def trips(a, b)
    # returns all of the trips between A and B
  end
end

if __FILE__ == $0
  graph = Graph.create_from_input_string(STDIN.read)
  abc = Route.new("ABC")
  puts graph.distance(abc)
end
