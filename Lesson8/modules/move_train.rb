module MoveTrain
  private

  def move_train
    puts '============Перемещение поезда по маршруту============'
    show_train
    train_id = show_message('Выберете поезд для перемещения', true)
    return if train_id.nil?

    print_move_train(@trains[train_id])
  end

  def print_move_train(train)
    print_train_action(train) if train
  end

  def print_train_action(train)
    loop do
      puts "Поезд #{train.id}" \
           " находится на станции #{train.current_station.name}"
      puts '[n] - для перемещения на следующую станцию'
      puts '[p] - для перемещения на предыдущую станцию'
      action = show_message('')
      break if action.nil?

      move_train_action(action, train)
    end
  end

  def move_train_action(action, train)
    if action == 'n'
      train.station_up
    elsif action == 'p'
      train.station_down
    end
  end
end
