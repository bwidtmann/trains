require_relative '../test_helper.rb'

describe 'dfs' do

  def setup
    @railroad = Trains::RailRoad.new
    @railroad.add_town 'A'
    @railroad.add_town 'B'
    @railroad.add_town 'C'
    @railroad.add_town 'D'
    @railroad.add_town 'E'
    @railroad.add_connection('A', 'B', 5)
    @railroad.add_connection('B', 'C', 4)
    @railroad.add_connection('C', 'D', 8)
    @railroad.add_connection('D', 'C', 8)
    @railroad.add_connection('D', 'E', 6)
    @railroad.add_connection('A', 'D', 5)
    @railroad.add_connection('C', 'E', 2)
    @railroad.add_connection('E', 'B', 3)
    @railroad.add_connection('A', 'E', 7)
    @dfs = Trains::Dfs.new(@railroad)
  end

  it 'initialize' do
    @dfs.rail_road.towns.count.must_equal 5
  end

  it 'traverse' do
    @dfs.route('A', 'C', 2, 2).must_equal 2
    @dfs.route('C', 'C', 0, 3).must_equal 2
    @dfs.route('A', 'C', 4, 4).must_equal 3
  end

end