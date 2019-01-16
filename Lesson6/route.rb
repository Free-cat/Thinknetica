class Route
  attr_accessor :stations
  attr_reader :name

  def initialize(name, start_station, end_station)
    @name = name
    @stations = [start_station, end_station]
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
