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

    def route(town_names)
      # TODO implement algorithm (e.g. dijkstra)
      'NO SUCH ROUTE'
    end
  end
end