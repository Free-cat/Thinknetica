class Train
  attr_accessor :id, :type, :wagons_count, :speed
  attr_reader :route

  def initialize(id, type, wagons_count)
    @id = id
    @type = type
    @wagons_count = wagons_count
    @speed = 0
  end

  def stop
    self.speed = 0
  end

  def pick_up_speed(speed)
    self.speed = speed
  end

  def add_wagon
    self.wagons_count += 1 if speed.zero?
  end

  def delete_wagon
    self.wagons_count -= 1 if speed.zero? && wagons_count > 0
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
