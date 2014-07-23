require_relative 'rail_road'
require 'logger'

module Trains
  class Dijkstra
    attr_accessor :rail_road, :towns, :log

    def initialize(rail_road)
      @rail_road = rail_road
      # we have to copy all towns in order to not destroy the original graph
      @towns = deep_copy(rail_road.towns)
      @log = Logger.new(STDOUT)
    end

    def get_nearest_town
      towns.min_by { |town| town.distance}
    end

    def get_town_by_name(town_name)
      towns.select { |town| town.name == town_name}[0]
    end

    def shortest_route(source_town_name, destination_town_name)
      @towns = deep_copy(rail_road.towns)
      source_town = get_town_by_name(source_town_name)
      source_town.distance = 0 # start at source town
      until towns.empty?
        nearest_town = get_nearest_town
        log.info "visit town #{nearest_town.name}"

        # check end criterion
        break if nearest_town.distance == Float::INFINITY || (nearest_town.name == destination_town_name && nearest_town.distance > 0)

        nearest_town.adjacencies.each do |adjacency|
          new_distance = nearest_town.distance + rail_road.get_connection_by_town_names(nearest_town.name, adjacency.name).length
          adjacency.distance = new_distance if new_distance < adjacency.distance
          log.info "new distance to #{adjacency.name} is now #{adjacency.name}"
        end
        # solve problem if route from 'B' to 'B'
        if (source_town_name == destination_town_name && nearest_town.distance == 0)
          nearest_town.distance = Float::INFINITY
        else
          log.info "delete town #{nearest_town.name}"
          towns.delete nearest_town
        end
      end
      nearest_town.distance
    end

    private

    def deep_copy(object)
      Marshal.load(Marshal.dump(object))
    end
  end
end