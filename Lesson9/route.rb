require_relative 'instance_counter/instance_counter'
require_relative 'modules/validation'

class Route
  include Validation
  include InstanceCounter
  attr_accessor :stations
  attr_reader :name

  validate :stations, :type, Station
  validate :stations, :length, 2

  def initialize(name, start_station, end_station)
    @name = name
    @stations = [start_station, end_station]
    validate!
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station)
  end

  def all_stations
    stations.each { |station| puts station.name }
  end

  def show_stations
    stations.each_with_index do |station, index|
      puts "#{index}: #{station.name}"
    end
  end
end
