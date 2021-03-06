class CargoWagon < Wagon
  attr_accessor :capacity
  attr_reader :occupied_capacity

  def initialize(company_name, capacity)
    super('cargo', company_name)
    @capacity = capacity
    @occupied_capacity = 0
    validate_cargo!
  end

  def free_capacity
    capacity - occupied_capacity
  end

  def take_capacity(capacity_to_place)
    if (occupied_capacity + capacity_to_place) > capacity
      raise 'Все место в вагоне уже занято'
    end

    @occupied_capacity += capacity_to_place
  end

  def validate_cargo!
    raise 'Объем может быть только числом' unless capacity.is_a?(Numeric)
  end

  def valid?
    validate_cargo!
    true
  rescue StandardError
    false
  end
end
