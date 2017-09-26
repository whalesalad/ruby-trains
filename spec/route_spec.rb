require_relative '../lib/trains/route'

describe Trains::Route do
  describe 'when we are dealing with a single route' do
    let(:route) do
      Trains::Route.new("CDE").tap { |r| r.distance = 10 }
    end

    it 'provides a start' do
      expect(route.start).to eq('C')
    end

    it 'provides a terminus' do
      expect(route.terminus).to eq('E')
    end

    it 'provides a distance' do
      expect(route.distance).to eq(10)
    end

    it 'provides the number of stops' do
      expect(route.stops).to eq(2)
    end

    it 'provides a max_stops_of helper' do
      expect(route.max_stops_of(2)).to be true
    end
  end

  describe 'when we have a collection of routes' do
    let(:routes) do
      [Trains::Route.new("ABCDE", distance:10),
       Trains::Route.new("CDE", distance:5)]
    end

    it 'allows us to sort by distance' do
      route = routes.sort_by(&:distance).first
      expect(route.to_s).to eq('CDE')
    end

    it 'allows us to find by max stops' do
      route = routes.detect { |r| r.max_stops_of 3 }
      expect(route.to_s).to eq('CDE')
    end

    it 'allows us to find by exact stops' do
      route = routes.detect { |r| r.exact_stops 4 }
      expect(route.to_s).to eq('ABCDE')
    end
  end
end
