require_relative 'instance_counter/instance_counter'
require_relative 'modules/validation'

class Station
  include Validation
  include InstanceCounter
  attr_reader :name, :trains

  validate :name, :presence
  validate :name, :length, 3

  @@stations = []
  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def accept_train(train)
    trains << train
  end

  def direct_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  def all_train
    trains
  end

  def train_block
    trains.each { |train| yield(train) }
  end
end
