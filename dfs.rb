require_relative 'rail_road'
require 'logger'

module Trains
  class Dfs
    attr_accessor :rail_road, :stack, :log

    def initialize(rail_road)
      @rail_road = rail_road
      @stack = Array.new
      @log = Logger.new(STDOUT)
    end

    def reached_end?
      if @distance
        (rail_road.route(@stack.map(&:name)) >= @distance) #(town.name == @destination_town.name and @counter > 1) and (@stack.size - 1).between?(@min_stops, @max_stops)
      else
        (@stack.size - 1) == @max_stops #(town.name == @destination_town.name and @counter > 1) and (@stack.size - 1).between?(@min_stops, @max_stops)
      end
    end

    def check_if_trip(town)
      if @distance
        if (rail_road.route(@stack.map(&:name)) < @distance) and (town.name == @destination_town.name and @stack.size > 1)#@exact_stops == (@stack.size - 1) or (@exact_stops - 1) == (@stack.size - 1)
          log.info "found a trip!"
          @trips += 1
        end
      else
        # ((@stack.size - 1) >= @min_stops) and
        if (@stack.size - 1).between?(@min_stops, @max_stops) and (town.name == @destination_town.name and @stack.size > 1)#@exact_stops == (@stack.size - 1) or (@exact_stops - 1) == (@stack.size - 1)
          log.info "found a trip!"
          @trips += 1
        end
      end
    end

    def traverse(town)
      #return if @counter > 100
      #@counter += 1
      log.info "visit town #{town.name}"
      @stack.push(town)
      log.info "stack is #{@stack.map(&:name)}"
      log.info "distance is #{rail_road.route(@stack.map(&:name)).to_s}"

      check_if_trip(town)

      # check for end criterion
      if reached_end?
        log.info "reached end criterion"
      else
        log.info "NOT reached end criterion -> so try all adjacencies recursively"
        town.adjacencies.each do |adjacency|
          traverse(adjacency)
        end
      end

      # pop town from stack as it has been processed
      @stack.pop

    end

    def route_with_stops(source_town_name, destination_town_name, min_stops, max_stops)
      source_town = rail_road.get_town_by_name(source_town_name)
      @destination_town = rail_road.get_town_by_name(destination_town_name)
      @min_stops = min_stops
      @max_stops = max_stops
      @trips = 0
      #@counter = 0

      traverse(source_town)
      #puts @stack.size
      @trips
    end

    def route_with_distance(source_town_name, destination_town_name, distance)
      source_town = rail_road.get_town_by_name(source_town_name)
      @destination_town = rail_road.get_town_by_name(destination_town_name)
      @distance = distance
      @trips = 0
      #@counter = 0

      traverse(source_town)
      #puts @stack.size
      @trips
    end
  end
end