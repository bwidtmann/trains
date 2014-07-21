module Trains
  class Connection
    attr_accessor :source_town, :destination_town, :length, :rail_road

    def initialize(source_town, destination_town, length)
      self.source_town = source_town
      self.destination_town = destination_town
      self.length = length
    end
  end
end