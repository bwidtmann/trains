require 'logger'

$log = Logger.new(STDOUT)
$log.level = Logger::WARN

require_relative 'dfs'
require_relative 'dijkstra'