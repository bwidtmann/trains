require_relative 'rail_road'

module Trains
  class Dijkstra
    attr_accessor :rail_road, :towns

    def initialize(rail_road)
      @rail_road = rail_road
      @towns = deep_copy(rail_road.towns)
    end

    def get_nearest_town
      towns.min_by { |town| town.distance}
    end

    def get_town_by_name(town_name)
      towns.select { |town| town.name == town_name}[0]
    end

    def shortest_route(source_town_name, destination_town_name)
      source_town = get_town_by_name(source_town_name)
      source_town.distance = 0
      #visited_town = nil
      until towns.empty?

        nearest_town = get_nearest_town
        #puts('nearest_town: ' + nearest_town.name)
        #nearest_town.predecessor = visited_town
        break if nearest_town.distance == Float::INFINITY || (nearest_town.name == destination_town_name && nearest_town.distance > 0)

        nearest_town.adjacencies.each do |adjacency|
          new_distance = nearest_town.distance + rail_road.get_connection_by_town_names(nearest_town.name, adjacency.name).length
          adjacency.distance = new_distance if new_distance < adjacency.distance
        end
        #visited_town = deep_copy(nearest_town)
        if (source_town_name == destination_town_name && nearest_town.distance == 0)
          nearest_town.distance = Float::INFINITY
        else
          towns.delete nearest_town
        end
        #puts '------------------------'
        #towns.each do |town|
        #  puts(town.name + town.distance.to_s)
        #end
      end
      nearest_town.distance
    end

    private

    def deep_copy(object)
      Marshal.load(Marshal.dump(object))
    end
  end
end