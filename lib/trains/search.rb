module Trains
  class DepthFirstSearch
    # Uses a depth-first strategy to find all paths in a graph.

    MAX_DEPTH = 10 # safe ceiling based on requirements

    attr_accessor :graph, :depth, :paths

    def initialize(graph, start, terminus)
      @graph = graph
      @terminus = terminus
      @paths = []

      search(start)
    end

    private

    def children_for(vertex)
      graph.get_vertex(vertex).neighbors
    end

    def match?(vertex)
      vertex.eql? @terminus
    end

    def search(node, depth=[])
      # Prevent infinite recursion.
      return if depth.size > MAX_DEPTH

      # If we have a match, add our breadcrumbs (depth) unless we're just starting out.
      if match? node
        paths << depth + [node] unless depth.empty?
      end

      # Work down the tree in a recursive fashion
      children_for(node).each do |c|
        search(c, depth+[node])
      end
    end
  end
end
