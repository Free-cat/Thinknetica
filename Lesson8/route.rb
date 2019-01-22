require_relative 'instance_counter/instance_counter'

class Route
  include InstanceCounter
  attr_accessor :stations
  attr_reader :name

  def initialize(name, start_station, end_station)
    @name = name
    @stations = [start_station, end_station]
    validate!
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
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

  protected

  def validate!
    raise 'Station not Station class' unless stations.all? { |station| station.is_a?(Station) }
    raise "Station's array is a small, minimum 2 station" if stations.length < 2
  end
end
