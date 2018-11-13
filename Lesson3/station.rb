class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    trains << train
  end

  def direct_train(train)
    trains.delete(train)
  end

  def all_train_in_station
    trains.each { |train| puts train.id }
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }.each do |train|
      puts train.id
    end
  end
end
