require_relative 'modules/accessors'

class CargoWagon < Wagon
  extend Accessors
  attr_accessor :capacity
  attr_accessor_with_history :occupied_capacity

  validate :capacity, :type, Numeric

  def initialize(company_name, capacity)
    super('cargo', company_name)
    @capacity = capacity
    self.occupied_capacity = 0
    validate!
  end

  def free_capacity
    capacity - self.occupied_capacity
  end

  def take_capacity(capacity_to_place)
    if (occupied_capacity.to_i + capacity_to_place) > capacity
      raise 'Все место в вагоне уже занято'
    end

    self.occupied_capacity += capacity_to_place
  end
end
