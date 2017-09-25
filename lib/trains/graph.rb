require_relative './edge'
require_relative './route'
require_relative './vertex'
require_relative './search'

module Trains
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
      return verticies[vertex] ||= Vertex.new
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
      unless route.is_a? Route
        route = Route.new(route)
      end

      # returns a collection of edges for a route
      edges = []

      route.segments.each do |a, b|
        # does a vertex exist at all?
        vertex = get_vertex(a)
        edge = vertex.connection_to(b)

        # If we cannot find any edge in our sequence, die.
        return false if not edge

        edges << edge
      end

      return edges
    end

    def distance(route)
      route_edges = edges_for_route(route)

      if not route_edges
        nil
      else
        route_edges.map { |e| e.distance }.inject(:+)
      end
    end

    def trips(start, terminus)
      search = DepthFirstSearch.new(self, start, terminus)
        .paths
        .map { |r| Route.from_parts(r) }
        .each { |r| r.distance = distance(r) }
    end
  end
end
