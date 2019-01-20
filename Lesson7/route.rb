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
  rescue
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
    raise "Name can't be nil and blank" if name.nil?
    raise "Name should be at least 3 symbols" if name.to_s.length < 3
    raise "Start station can't be nil" if stations.first.nil?
    raise "Start station can't be type Station" if stations.first.class.name != "Station"
    raise "End station can't be nil" if stations.last.nil?
    raise "End station can't be type Station" if stations.last.class.name != "Station"
  end
end
