require_relative 'company_name/company_name'
require_relative 'instance_counter/instance_counter'
require_relative 'modules/validation'

class Train
  include Validation
  include CompanyName
  include InstanceCounter
  attr_accessor :id, :type, :wagons, :speed
  attr_reader :route

  validate :id, :presence
  validate :type, :presence
  validate :company_name, :presence
  validate :id, :format, /^[a-zа-я\d]{3}(-)?[a-zа-я\d]{2}$/i.freeze
  @@trains = {}

  # TRAIN_ID_FORMAT = /^[a-zа-я\d]{3}(-)?[a-zа-я\d]{2}$/i.freeze

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

  def wagon_block
    wagons.each_with_index { |wagon, index| yield(wagon, index) }
  end

  def print_wagons_info
    wagon_block do |w, i|
      "- #{i}, #{w.type}, #{w.free_capacity}, #{w.occupied_capacity}"
    end
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
    @wagons.delete_at(-1) if speed.zero? && !wagons.empty?
  end

  def route=(route)
    @route = route
    @current_station_index = 0
    current_station.accept_train(self)
  end

  def station_up
    station_up_process if next_station
  end

  def station_down
    station_down_process if prev_station
  end

  def current_station
    route.stations[@current_station_index] if route
  end

  def prev_station
    prev_station_process if route && @current_station_index >= 1
  end

  def next_station
    route.stations[@current_station_index + 1] if route
  end

  protected

  def station_down_process
    current_station.direct_train(self)
    @current_station_index -= 1
    current_station.accept_train(self)
  end

  def station_up_process
    current_station.direct_train(self)
    @current_station_index += 1
    current_station.accept_train(self)
  end

  def prev_station_process
    route.stations[@current_station_index - 1]
  end
end
