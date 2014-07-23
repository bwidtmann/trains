module Trains
  class Town
    attr_accessor :name, :adjacencies, :connections, :distance

    def initialize(name)
      @name = name
      @distance = Float::INFINITY
      @adjacencies = Array.new
      @connections = Array.new
    end

    def get_connection_to_town(town_name)
      connections.select { |connection| connection.destination_town.name == town_name}[0]
    end
  end
end