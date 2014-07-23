require_relative 'rail_road'
require 'logger'

module Trains
  class Dfs
    attr :rail_road, :stack, :opts, :log

    def initialize(rail_road)
      @rail_road = rail_road
      @stack = Array.new
      @log = Logger.new(STDOUT)
    end

    def stops_or_distance
      if opts[:criterion] == :stops
        stack.size - 1
      else
        rail_road.route(stack.map(&:name))
      end
    end

    def reached_end?
      stops_or_distance >= opts[:max]
    end

    def check_if_trip(town)
      if town.name == @destination_town.name and stack.size > 1
        if stops_or_distance.between?(opts[:min], opts[:max])
          log.info "found a trip!"
          @trips += 1
        end
      end
    end

    def traverse(town)
      @stack.push(town)
      log.info "visit town #{town.name}"
      log.info "stack is #{stack.map(&:name)}"

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
      stack.pop
    end

    def route(source_town_name, destination_town_name, opts = {})
      @opts = opts
      source_town = rail_road.get_town_by_name(source_town_name)
      @destination_town = rail_road.get_town_by_name(destination_town_name)
      @trips = 0

      traverse(source_town)

      @trips
    end
  end
end