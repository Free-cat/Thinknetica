require_relative 'company_name/company_name'
require_relative 'instance_counter/instance_counter'

class Train
  include CompanyName
  include InstanceCounter
  attr_accessor :id, :type, :wagons, :speed
  attr_reader :route
  @@trains = {}

  TRAIN_ID_FORMAT = /^[a-zа-я\d]{3}(-)?[a-zа-я\d]{2}$/i.freeze

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
    validate!
    @@trains[id] = self
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def wagon_block
    wagons.each_with_index { |wagon, index| yield(wagon, index) }
  end

  def print_wagons_info
    wagon_block { |wagon, index| "- #{index}, #{wagon.type}, Свободно: #{wagon.free_capacity}, Занято: #{wagon.occupied_capacity}" }
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
    @wagons.delete_at(-1) if speed.zero? && !wagons_count.empty?
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

  protected

  def validate!
    raise "ID can't be nil and blank" if id.nil?
    raise "Type can't be nil" if type.nil? || type == ''
    raise "Company_name can't be nil and blank" if company_name.nil? || company_name == ''
    raise 'ID Format Error, example: (123-ab, abc-ab, abc12 etc..)' if id !~ TRAIN_ID_FORMAT
  end
end
