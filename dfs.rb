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

    def traverse(town)
#      return if @counter > 25
#      @counter += 1
      log.info "visit town #{town.name}"
      @stack.push(town)

      if (@stack.size - 1).between?(@min_stops, @max_stops) and (town.name == @destination_town.name and @stack.size > 1)#@exact_stops == (@stack.size - 1) or (@exact_stops - 1) == (@stack.size - 1)
        log.info "found a trip!"
        @trips += 1
      end

      #puts "stack pushed to size: " + @stack.size.to_s
      #puts "distance increased to: " + rail_road.route(@stack.map(&:name)).to_s

      # check for end criterion
      if (@stack.size - 1) == @max_stops #(town.name == @destination_town.name and @counter > 1) and (@stack.size - 1).between?(@min_stops, @max_stops)
        log.info "reached end criterion"
      else
        log.info "NOT reached end criterion -> so try all adjacencies recursively"
        town.adjacencies.each do |adjacency|
          #puts "adjacency from town " + town.name
          traverse(adjacency)
        end
      end

      # pop town from stack as it has been processed
      @stack.pop
      #puts "stack popped to size: " + @stack.size.to_s
    end

    def route(source_town_name, destination_town_name, min_stops, max_stops)
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
  end
end