require_relative 'town'
require_relative 'connection'

module Trains
  class RailRoad
    attr_accessor :towns, :connections

    def initialize
      self.towns = Array.new
      self.connections = Array.new
    end

    def add_town(town_name)
      town = Town.new(town_name)
      self.towns << town
      town.rail_road = self
    end

    def add_connection(source_town_name, destination_town_name, length)
      source_town = self.get_town_by_name(source_town_name)
      destination_town = self.get_town_by_name(destination_town_name)
      connection = Connection.new(source_town, destination_town, length)
      self.connections << connection
      connection.rail_road = self
    end

    def get_town_by_name(town_name)
      self.towns.select { |town| town.name == town_name}[0]
    end

    def get_connection_by_town_names(source_town_name, destination_town_name)
      self.connections.select { |connection| connection.source_town.name == source_town_name && connection.destination_town.name == destination_town_name }[0]
    end

    def route(town_names)
      route = 0
      (town_names.size - 1).times do
        connection = self.get_connection_by_town_names(town_names.shift, town_names[0])
        if connection
          route += connection.length
        else
          return 'NO SUCH ROUTE'
        end
      end
      return route
    end
  end
end