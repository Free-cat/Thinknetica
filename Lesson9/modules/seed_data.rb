module SeedData
  def create_seed_stations
    stations = []
    stations << Station.new('station1')
    stations << Station.new('station2')
    stations << Station.new('station3')
    stations << Station.new('station4')
    stations << Station.new('station5')
    stations << Station.new('station6')
    stations
  end

  def create_seed_cargo
    trains = []
    trains << a = CargoTrain.new('car-01', 'cargo_train1')
    trains << b = CargoTrain.new('car-02', 'cargo_train2')
    trains << c = CargoTrain.new('car-03', 'cargo_train3')
    3.times { |i| a.add_wagon(CargoWagon.new("car-01-wagon-#{i}", 10.25)) }
    3.times { |i| b.add_wagon(CargoWagon.new("car-02-wagon-#{i}", 20)) }
    3.times { |i| c.add_wagon(CargoWagon.new("car-03-wagon-#{i}", 40)) }
    trains
  end

  def create_seed_passenger
    trains = []
    trains << pt1 = PassengerTrain.new('pas-01', 'passenger_train1')
    trains << pt2 = PassengerTrain.new('pas-02', 'passenger_train2')
    trains << pt3 = PassengerTrain.new('pas-03', 'passenger_train3')
    3.times { |i| pt1.add_wagon(PassengerWagon.new("pas-01-wagon-#{i}", 10)) }
    3.times { |i| pt2.add_wagon(PassengerWagon.new("pas-01-wagon-#{i}", 20)) }
    3.times { |i| pt3.add_wagon(PassengerWagon.new("pas-01-wagon-#{i}", 30)) }
    trains
  end
end
