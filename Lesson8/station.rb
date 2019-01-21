require_relative 'instance_counter/instance_counter'

class Station
  include InstanceCounter
  attr_reader :name, :trains

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

  def valid?
    validate!
    true
  rescue
    false
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

  def train_block(&b)
    trains.each{|train| b.call(train)}
  end

  protected
  def validate!
    raise "Name can't be nil and blank" if name.nil?
    raise "Name should be at least 3 symbols" if name.to_s.length < 3
  end
end


