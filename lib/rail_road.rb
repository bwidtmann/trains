require_relative 'town'
require_relative 'connection'

module Trains
  class RailRoad
    attr :towns

    def initialize
      @towns = Array.new
    end

    def add_town(town_name)
      town = Town.new(town_name)
      towns << town
    end

    def add_connection(source_town_name, destination_town_name, length)
      source_town = get_town_by_name(source_town_name)
      destination_town = get_town_by_name(destination_town_name)
      Connection.new(source_town, destination_town, length)
    end

    def get_town_by_name(town_name)
      towns.select { |town| town.name == town_name}[0]
    end

    def route(town_names)
      route = 0
      (town_names.size - 1).times do
        connection = get_town_by_name(town_names.shift).get_connection_to_town(town_names[0])
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