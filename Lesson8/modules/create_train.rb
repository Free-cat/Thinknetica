module CreateTrain
  private

  def create_stations
    puts '============Создание станции============'
    loop do
      begin
        break unless create_station
      rescue StandardError => e
        retry if retry?(e)
      end
    end
  end

  def create_station
    message = 'Введите название станции или ENTER для завершения'
    station_name = show_message(message)

    false if station_name.nil?

    @stations << Station.new(station_name)
    puts "Станция #{station_name} успешно создана"
  end

  def create_trains
    loop do
      create_trains_show_menu

      train_type = gets.chomp.to_i
      break if train_type.nil? || train_type.zero?

      create_train(train_type)
    end
  end

  def create_trains_show_menu
    puts '============Создание поездов============'
    puts "Выберете тип поезда для создания:\n
      [1] Создавать пассажирский поезд
      [2] Создавать грузовой поезд
      [0] Назад
      "
  end

  def create_train(train_type)
    train_id, train_company_name = train_data
    if train_type == 1
      create_passenger_train(train_id, train_company_name)
    elsif train_type == 2
      create_cargo_train(train_id, train_company_name)
    end
  rescue StandardError => e
    retry if retry?(e)
  end

  def train_data
    train_id = show_message('Введите ID поезда или ENTER для завершения')
    train_company_name = show_message('Введите производителя поезда')
    [train_id, train_company_name]
  end

  def create_passenger_train(train_id, train_company_name)
    train = PassengerTrain.new(train_id, train_company_name)
    puts "Пассажирский поезд c номером #{train.id}" \
         " производителя #{train.company_name} успешно создан"
    @trains << train
  end

  def create_cargo_train(train_id, train_company_name)
    train = CargoTrain.new(train_id, train_company_name)
    puts "Товарный поезд c номером #{train.id}" \
         " производителя #{train.company_name} успешно создан"
    @trains << train
  end
end
