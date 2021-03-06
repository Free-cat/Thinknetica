class PassengerWagon < Wagon
  attr_accessor :capacity
  attr_reader :occupied_capacity

  def initialize(company_name, seat_count)
    super('passenger', company_name)
    @capacity = seat_count
    @occupied_capacity = 0
    validate_passenger!
  end

  def free_capacity
    capacity - occupied_capacity
  end

  def take_capacity
    raise 'Все места в вагоне уже заняты' if occupied_capacity + 1 > capacity

    @occupied_capacity += 1
  end

  def validate_passenger!
    raise 'Capacity only integer' unless capacity.is_a?(Integer)
  end

  def valid?
    validate_passenger!
    true
  rescue StandardError
    false
  end
end
