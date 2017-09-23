require_relative '../trains'

describe Route do
  before do
    @route = Route.new("CDE")
  end

  it 'provides a start (a)' do
    expect(@route.start).to eq 'C'
  end

  it 'provides a terminus' do
    expect(@route.terminus).to eq 'E'
  end
end

describe Edge do
  it 'creates edges from input strings' do
    edge = Edge.from_string("AB4")

    expect(edge.start).to eq('A')
    expect(edge.terminus).to eq('B')
    expect(edge.distance).to eq(4)
  end

  before do
    @edge = Edge.from_string("BC8")
  end

  it 'provides a start' do
    expect(@edge.start).to eq('B')
  end

  it 'provides a terminus' do
    expect(@edge.terminus).to eq('C')
  end

  it 'provides a to_s method' do
    expect(@edge.to_s).to eq('BC8')
  end
end
