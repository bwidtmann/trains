module Trains
  class Connection
    attr_accessor :source_town, :destination_town, :length

    def initialize(source_town, destination_town, length)
      @source_town = source_town
      @destination_town = destination_town
      @length = length
      source_town.adjacencies << destination_town
      source_town.connections << self
    end
  end
end