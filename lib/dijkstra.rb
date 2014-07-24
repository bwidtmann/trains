require_relative 'rail_road'
require 'logger'

module Trains
  class Dijkstra
    attr :rail_road, :towns

    def initialize(rail_road)
      @rail_road = rail_road
    end

    def shortest_route(source_town_name, destination_town_name)
      # first we have to copy all towns in order to not destroy the original graph
      cloning_towns

      @destination_town_name = destination_town_name
      source_town = get_town_by_name(source_town_name)

      # start at source town
      source_town.distance = 0
      until towns.empty?
        nearest_town = get_nearest_town
        $log.info "visit town #{nearest_town.name}"

        # check end criterion
        break if reached_end?(nearest_town)

        nearest_town.adjacencies.each do |adjacency|
          new_distance = nearest_town.distance + rail_road.route([nearest_town.name, adjacency.name])
          adjacency.distance = new_distance if new_distance < adjacency.distance
          $log.info "new distance to #{adjacency.name} is now #{adjacency.name}"
        end

        # solve problem if route from 'B' to 'B'
        if (source_town_name == destination_town_name && nearest_town.distance == 0)
          nearest_town.distance = Float::INFINITY # reset town to 'not visited'
        else
          $log.info "delete town #{nearest_town.name}"
          towns.delete nearest_town # set town to 'visited'
        end
      end

      nearest_town.distance
    end

    private

    def cloning_towns
      # making a deep copy of all towns and connections as well
      @towns = Marshal.load(Marshal.dump(rail_road.towns))
    end

    def reached_end?(town)
      town.distance == Float::INFINITY || (town.name == @destination_town_name && town.distance > 0)
    end

    def get_nearest_town
      towns.min_by { |town| town.distance}
    end

    def get_town_by_name(town_name)
      towns.select { |town| town.name == town_name}[0]
    end
  end
end