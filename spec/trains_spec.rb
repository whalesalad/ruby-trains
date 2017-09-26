require_relative '../lib/trains'

describe Trains do
  context 'with the exercise test graph' do
    let(:graph) do
      Trains.make_graph("AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7")
    end

    it 'handles distance queries' do
      expect(graph.distance("ABC")).to eq(9)
      expect(graph.distance("AD")).to eq(5)
      expect(graph.distance("ADC")).to eq(13)
      expect(graph.distance("AEBCD")).to eq(22)
      expect(graph.distance("AED")).to eq(nil)
    end

    it 'finds trips from C to C, with a max of 3 stops' do
      routes = graph.trips('C', 'C').select { |route| route.max_stops_of 3 }

      expect(routes.size).to eq(2)
      expect(routes.map(&:to_s)).to match_array(["CDC", "CEBC"])
    end

    it 'finds trips from A to C, with exactly 4 stops' do
      routes = graph.trips('A', 'C').select { |route| route.exact_stops 4 }

      expect(routes.size).to eq(3)
      expect(routes.map(&:to_s)).to match_array(["ABCDC", "ADCDC", "ADEBC"])
    end

    it 'finds the length of the shortest route from A to C' do
      route = graph.trips('A', 'C').sort_by(&:distance).first
      expect(route.distance).to eq(9)
    end

    it 'finds the length of the shortest route from B to B' do
      route = graph.trips('B', 'B').sort_by(&:distance).first
      expect(route.distance).to eq(9)
    end

    it 'finds the number of routes between C and C with a distance of less than 30' do
      routes = graph.trips('C', 'C').select { |route| route.distance < 30 }
      expect(routes.size).to eq(7)
    end
  end
end
