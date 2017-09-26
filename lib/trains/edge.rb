require_relative './route'

module Trains
  class Edge < Route
    def self.from_string(input)
      re = /(?<route>[A-Z]+)(?<distance>\d+)/
      parts = re.match(input.strip).named_captures
      self.new(parts["route"], distance:parts["distance"])
    end
  end
end
