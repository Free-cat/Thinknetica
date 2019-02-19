require_relative 'modules/accessors'

class PassengerWagon < Wagon
  extend Accessors
  attr_accessor :capacity
  attr_accessor_with_history :occupied_capacity

  validate :capacity, :type, Integer

  def initialize(company_name, seat_count)
    super('passenger', company_name)
    @capacity = seat_count
    self.occupied_capacity = 0
    validate!
  end

  def free_capacity
    capacity - self.occupied_capacity
  end

  def take_capacity
    raise 'Все места в вагоне уже заняты' if occupied_capacity + 1 > capacity

    self.occupied_capacity += 1
  end
end
