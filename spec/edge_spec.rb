require_relative '../lib/trains/edge'

describe Trains::Edge do
  it 'creates edges from input strings' do
    edge = Trains::Edge.from_string("AB4")

    expect(edge.start).to eq('A')
    expect(edge.terminus).to eq('B')
    expect(edge.distance).to eq(4)
  end

  let(:edge) do
    Trains::Edge.from_string("BC8")
  end

  it 'provides a start' do
    expect(edge.start).to eq('B')
  end

  it 'provides a terminus' do
    expect(edge.terminus).to eq('C')
  end
end
