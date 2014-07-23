module Trains
  class Town
    attr_accessor :name, :adjacencies, :distance

    def initialize(name)
      @name = name
      @distance = Float::INFINITY
      @adjacencies = Array.new
    end
  end
end