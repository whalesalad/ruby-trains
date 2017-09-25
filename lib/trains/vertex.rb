module Trains
  class Vertex
    attr_accessor :edges

    def initialize
      @edges = []
    end

    def add_edge(edge)
      @edges << edge
    end

    def neighbors
      edges.map { |e| e.terminus }
    end

    def connection_to(vertex)
      edges.detect { |e| e.terminus.eql? vertex }
    end
  end
end
