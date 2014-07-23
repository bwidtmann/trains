module Trains
  class Connection
    attr_accessor :source_town, :destination_town, :length, :rail_road

    def initialize(source_town, destination_town, length)
      @source_town = source_town
      @destination_town = destination_town
      @length = length
      source_town.adjacencies << destination_town
    end
  end
end