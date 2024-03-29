require_relative '../test_helper.rb'

describe 'dijkstra' do

  def setup
    @railroad = Trains::RailRoad.new
    @railroad.add_town('Frankfurt')
    @railroad.add_town('Mannheim')
    @railroad.add_town('Wuerzburg')
    @railroad.add_town('Stuttgart')
    @railroad.add_town('Kassel')
    @railroad.add_town('Karlsruhe')
    @railroad.add_town('Erfurt')
    @railroad.add_town('Nuernberg')
    @railroad.add_town('Augsburg')
    @railroad.add_town('Muenchen')
    @railroad.add_connection('Frankfurt', 'Mannheim', 85)
    @railroad.add_connection('Frankfurt', 'Wuerzburg', 217)
    @railroad.add_connection('Frankfurt', 'Kassel', 173)
    @railroad.add_connection('Mannheim', 'Karlsruhe', 80)
    @railroad.add_connection('Wuerzburg', 'Erfurt', 186)
    @railroad.add_connection('Wuerzburg', 'Nuernberg', 103)
    @railroad.add_connection('Nuernberg', 'Stuttgart', 183)
    @railroad.add_connection('Karlsruhe', 'Augsburg', 250)
    @railroad.add_connection('Augsburg', 'Muenchen', 84)
    @railroad.add_connection('Nuernberg', 'Muenchen', 167)
    @railroad.add_connection('Kassel', 'Muenchen', 502)
    @dijkstra = Trains::Dijkstra.new(@railroad)
    @dijkstra.send(:cloning_towns)
  end

  it 'initialize' do
    @dijkstra.rail_road.towns.count.must_equal 10
    @dijkstra.rail_road.towns.first.distance.must_equal Float::INFINITY
    @dijkstra.rail_road.towns.last.distance.must_equal Float::INFINITY
  end

  it 'cloning towns' do
    @dijkstra.towns.first.distance = 99
    @dijkstra.towns.first.adjacencies.first.distance = 88
    # original graph should not be changed
    @railroad.towns.first.distance.must_equal Float::INFINITY
    @railroad.towns.first.adjacencies.first.distance.must_equal Float::INFINITY
  end

  it 'get nearest town' do
    nearest_town = @dijkstra.towns.first
    nearest_town.distance = 0
    @dijkstra.send(:get_nearest_town).must_equal nearest_town
  end

  it 'get town by name' do
    @dijkstra.send(:get_town_by_name, 'Muenchen').name.must_equal 'Muenchen'
    @dijkstra.send(:get_town_by_name, 'Augsburg').name.must_equal 'Augsburg'
  end

  it 'shortest route' do
    @dijkstra.shortest_route('Frankfurt','Muenchen').must_equal 487
    @dijkstra.shortest_route('Frankfurt','Augsburg').must_equal 415
  end

end