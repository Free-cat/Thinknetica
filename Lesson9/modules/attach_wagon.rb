module AttachWagon
  private

  def attach_wagon_to_train
    loop do
      show_train
      message = 'Выберете поезд или ENTER для завершения'
      train_index = show_message(message, true)
      break if train_index.nil?

      train = @trains[train_index]
      break if train.nil?
    end
  end

  def attach_wagon(train)
    message = 'Введите производителя вагона или ENTER для завершения'
    wagon_company_name = show_message(message)
    if train.type == 'cargo'
      attach_cargo_wagon(train, wagon_company_name)
    elsif train.type == 'passenger'
      attach_passenger_wagon(train, wagon_company_name)
    end
  rescue StandardError => e
    retry if retry?(e)
  end

  def attach_passenger_wagon(train, wagon_company_name)
    message = 'Введите количество мест в вагоне или ENTER для завершения'
    seat_count = show_message(message).to_i
    wagon = PassengerWagon.new(wagon_company_name, seat_count)
    train.add_wagon(wagon)
    wagon_attach_success(wagon.company_name, train.id)
  end

  def attach_cargo_wagon(train, wagon_company_name)
    message = 'Введите объем вагона или ENTER для завершения'
    wagon_capacity = show_message(message).to_f
    wagon = CargoWagon.new(wagon_company_name, wagon_capacity)
    train.add_wagon(wagon)
    wagon_attach_success(wagon.company_name, train.id)
  end

  def wagon_attach_success(wagon_company_name, train_id)
    puts "Вагон производителя #{wagon_company_name}" \
         " прицеплен к поезду #{train_id}"
  end

  def detach_wagon_of_train
    show_train
    train_index = show_message('Выберете поезд', true)
    train = @trains[train_index]
    if train
      train.delete_wagon
      puts "От поезда #{train.id} отцеплён вагон"
    else
      puts 'Данный поезд не найден'
    end
  end
end
