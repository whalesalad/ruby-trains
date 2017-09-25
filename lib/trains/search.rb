module Trains
  class DepthFirstSearch
    attr_accessor :graph, :start, :depth

    def initialize(graph, start, terminus)
      @graph = graph
      @start = start
      @terminus = terminus

      @paths = []

      children_for(start).each { |n| search(n) }
    end

    def children_for(vertex)
      graph.get_vertex(vertex).neighbors
    end

    def match?(vertex)
      vertex.eql? @terminus
    end

    def save_path(nodes)
      @paths << nodes
    end

    def paths
      # The paths the recursive search finds start one-layer deep
      # so let's add the start to all of our paths for presentation's sake.
      @paths.map { |p| [start] + p }
    end

    def search(node, depth=[])
      #    C
      #  D   E
      # C E   B
      #    B   C
      #     C

      depth << node

      # Die immediately if we've gone too deep.
      if depth.size > 30
        return false
      end

      # Get all of our children and check to see if any of them match
      children_for(node).each do |child|
        # If a child matches, take the current depth, add the child, and save as a path.
        if match? child
          save_path depth + [child]
        end

        # but we might still have more...
        search(child, depth)
      end

    end
  end
end
