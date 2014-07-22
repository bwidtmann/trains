module Trains
  class Town
    attr_accessor :rail_road, :name, :adjacencies, :distance

    def initialize(name)
      @name = name
      @distance = Float::INFINITY
      @adjacencies = Array.new
    end
  end
end