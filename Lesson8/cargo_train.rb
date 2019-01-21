class CargoTrain < Train
  def initialize(id, company_name)
    super(id, 'cargo', company_name)
  end
end