require_relative 'instance_counter/instance_counter'

class Station
  include InstanceCounter
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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
end


