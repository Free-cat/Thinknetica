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
    raise "Все место в вагоне уже занято" if occupied_capacity + capacity_to_place > capacity
    @occupied_capacity += capacity_to_place
  end

  def validate_cargo!
    raise "Объем может быть только числом" unless capacity.is_a?(Numeric)
  end

  def valid?
    begin
      validate_cargo!
      true
    rescue
      false
    end
  end

end