require_relative '../test_helper.rb'

describe 'rail_road' do

  def setup
    @railroad = Trains::RailRoad.new
    @railroad.add_town('A')
    @railroad.add_town('B')
    @railroad.add_town('C')
    @railroad.add_connection('A', 'B', 15)
    @railroad.add_connection('B', 'A', 11)
    @railroad.add_connection('B', 'C', 9)
  end

  it 'add towns' do
    @railroad.towns.count.must_equal 3
  end

  it 'get town by name' do
    @railroad.get_town_by_name('A').name.must_equal 'A'
    @railroad.get_town_by_name('B').name.must_equal 'B'
  end

  it 'add connections' do
    @railroad.connections.count.must_equal 3
    @railroad.connections.first.length.must_equal 15
    @railroad.connections.first.destination_town.name.must_equal 'B'
  end

  it 'get route for two towns' do
    @railroad.route(['A','B']).must_equal 15
  end

  it 'get error message if there is no route for two towns' do
    @railroad.route(['A','C']).must_equal 'NO SUCH ROUTE'
  end

  it 'get route for three towns' do
    @railroad.route(['A','B','C']).must_equal 24
  end

end