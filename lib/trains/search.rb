module Trains
  class DepthFirstSearch
    attr_accessor :graph, :start, :depth, :paths

    def initialize(graph, start, terminus)
      @graph = graph
      @start = start
      @terminus = terminus
      @paths = []

      search(start)
    end

    def children_for(vertex)
      graph.get_vertex(vertex).neighbors
    end

    def match?(vertex)
      vertex.eql? @terminus
    end

    def search(node, depth=[])
      if depth.size > 10
        return
      end

      if match? node
        paths << depth + [node] unless depth.empty?
      end

      children_for(node).each do |c|
        search(c, depth+[node])
      end
    end
  end
end
