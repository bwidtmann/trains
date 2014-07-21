require_relative '../test_helper.rb'

describe 'rail_road' do

  def setup
    @railroad = Trains::RailRoad.new
    @railroad.add_town('A')
    @railroad.add_town('B')
    @railroad.add_connection('A', 'B', 15)
    @railroad.add_connection('B', 'A', 11)
  end

  it 'add towns' do
    @railroad.towns.count.must_equal 2
  end

  it 'get town by name' do
    @railroad.get_town_by_name('A').name.must_equal 'A'
    @railroad.get_town_by_name('B').name.must_equal 'B'
  end

  it 'add connections' do
    @railroad.connections.count.must_equal 2
    @railroad.connections.first.length.must_equal 15
    @railroad.connections.last.length.must_equal 11
    @railroad.connections.first.destination_town.name.must_equal 'B'
  end

end