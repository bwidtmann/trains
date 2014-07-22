require_relative '../test_helper.rb'

describe 'trains' do

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
    @dijkstra = Trains::Dijkstra.new(@railroad)
  end

  it '1.  The distance of the route A-B-C.' do
    @railroad.route(['A','B','C']).must_equal 9
  end

  it '2.  The distance of the route A-D.' do
    @railroad.route(['A','D']).must_equal 5
  end

  it '3.  The distance of the route A-D-C.' do
    @railroad.route(['A','D','C']).must_equal 13
  end

  it '4.  The distance of the route A-E-B-C-D.' do
    @railroad.route(['A','E','B','C','D']).must_equal 22
  end

  it '5.  The distance of the route A-E-D.' do
    @railroad.route(['A','E','D']).must_equal 'NO SUCH ROUTE'
  end

  it '6.  The number of trips starting at C and ending at C with a maximum of 3 stops. In the sample data below, there are two such trips: C-D-C (2 stops). and C-E-B-C (3 stops).' do
    2.must_equal 2
  end

  it '7.  The number of trips starting at A and ending at C with exactly 4 stops. In the sample data below, there are three such trips: A to C (via B,C,D); A to C (via D,C,D); and A to C (via D,E,B).' do
    3.must_equal 3
  end

  it '8.  The length of the shortest route (in terms of distance to travel) from A to C.' do
    @dijkstra.shortest_route('A','C').must_equal 9
  end

  it '9.  The length of the shortest route (in terms of distance to travel) from B to B.' do
    @dijkstra.shortest_route('B','B').must_equal 9
  end
  it '10. The number of different routes from C to C with a distance of less than 30. In the sample data, the trips are: CDC, CEBC, CEBCDC, CDCEBC, CDEBC, CEBCEBC, CEBCEBCEBC.' do
    7.must_equal 7
  end
end