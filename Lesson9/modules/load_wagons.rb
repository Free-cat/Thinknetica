module LoadWagons
  private

  def load_wagons
    loop do
      show_train
      message = 'Выберете поезд или ENTER для завершения'
      train_index = show_message(message, true)
      break if train_index.nil?

      train = @trains[train_index]
      break if train.nil?

      wagon_load_from_train(train)
    end
  end

  def show_wagons(train)
    train.wagon_block &show_station_wagon_block
  end

  def wagon_load_from_train(train)
    loop do
      show_wagons(train)
      message = 'Выберете вагон или ENTER для завершения'
      wagon_index = show_message(message, true)
      break if wagon_index.nil?

      load_wagon(train, wagon_index)
    end
  end

  def load_wagon(train, wagon_index)
    wagon = train.wagons[wagon_index]
    if wagon.is_a?(PassengerWagon)
      load_passenger_wagon(wagon, wagon_index)
    elsif wagon.is_a?(CargoWagon)
      load_cargo_wagon(wagon, wagon_index)
    end
  rescue StandardError => e
    retry if retry?(e)
  end

  def load_passenger_wagon(wagon, wagon_index)
    wagon.take_capacity
    puts "Пассажир занял место в вагоне #{wagon_index}"
  end

  def load_cargo_wagon(wagon, wagon_index)
    message = 'Введите количество груза или ENTER для завершения'
    value = show_message(message).to_f
    wagon.take_capacity(value)
    puts "Вагон #{wagon_index} загружен"
  end
end
