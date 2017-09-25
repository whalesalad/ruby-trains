$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib"

require 'trains/graph'
require 'trains/route'

module Trains
  def self.make_graph(string)
    Trains::Graph.create_from_input_string(string)
  end
end
