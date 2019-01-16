require_relative 'company_name/company_name'
require_relative 'instance_counter/instance_counter'

class Train
  include CompanyName
  include InstanceCounter
  attr_accessor :id, :type, :wagons_count, :speed
  attr_reader :route
  @@trains = {}

  class << self
    def find(id)
      @@trains[id]
    end
  end

  def initialize(id, type, company_name)
    @id = id
    @type = type
    @wagons = []
    @speed = 0
    @company_name = company_name
    @@trains[id] = (self)
    register_instance
  end

  def stop
    self.speed = 0
  end

  def pick_up_speed(speed)
    self.speed = speed
  end

  def add_wagon(wagon)
    @wagons << wagon if speed.zero? && wagon.type == type
  end

  def delete_wagon
    @wagons.delete_at(-1) if speed.zero? && wagons_count.size > 0
  end

  def route=(route)
    @route = route
    @current_station_index = 0
    current_station.accept_train(self)
  end

  def station_up
    if next_station
      current_station.direct_train(self)
      @current_station_index += 1
      current_station.accept_train(self)
    end
  end

  def station_down
    if prev_station
      current_station.direct_train(self)
      @current_station_index -= 1
      current_station.accept_train(self)
    end
  end

  def current_station
    route.stations[@current_station_index] if route
  end

  def prev_station
    route.stations[@current_station_index - 1] if route && @current_station_index >= 1
  end

  def next_station
    route.stations[@current_station_index + 1] if route
  end
end
