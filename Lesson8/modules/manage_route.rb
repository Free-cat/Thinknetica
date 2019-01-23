module ManageRoute
  private

  def manage_route
    loop do
      manage_route_menu_print
      action_route = gets.chomp.to_i
      break if action_route.zero?

      manage_route_action(action_route)
    end
  end

  def manage_route_menu_print
    puts '============Менеджер маршрутами============'
    puts "Выберете действие:\n
      [1] Создавать маршрут
      [2] Управление маршрутом
      [0] Назад
      "
  end

  def manage_route_action(action_route)
    if action_route == 1
      create_route
    elsif action_route == 2
      manage_route_config
    else
      puts 'Команда не найдена!'
    end
  end

  def manage_route_config
    route = route_select

    puts "Выберете действие:\n
        [1] Добавить станцию
        [2] Удалить станцию
        [0] Назад
        "
    case gets.chomp
    when '1' then add_station_route(route)
    when '2' then del_station_in_route(route)
    end
  end

  def route_select
    puts '============Управление маршрутами============'
    puts 'Выберете маршрут:'
    show_route
    @routes[show_message('Выберете маршрут:', true)]
  end

  def add_station_route(route)
    show_stations
    station = show_message('Выберете станцию для добавления', true)
    if @stations[station]
      route.add_station(@stations[station])
      puts 'Станция успешно добавлена'
    else
      puts 'Станция не найдена'
      nil
    end
  end

  def del_station_in_route(route)
    puts "Список станций маршрута #{route.name}"
    route.show_stations
    station = show_message('Выберете станцию для удаления', true)
    return if station.nil?

    if route.delete_station(route.show_stations[station])
      puts 'Станция успешно удалена!'
    else
      puts 'Неверный индекс'
    end
  end

  def create_route
    if @stations.size > 2
      puts '============Создание нового маршрута============'
      puts 'Доступные станции для добавления:'
      show_stations
      create_route_get_data
    else
      puts 'Необходимо больше 2-х станций для создание маршрута'
    end
  end

  def create_route_get_data
    name = show_message('Введите имя маршрута')
    @routes << Route.new(name,
                         create_route_first_station,
                         create_route_last_station)
    puts "Маршрут #{name} успешно создан"
  rescue StandardError => e
    retry if retry?(e)
  end

  def create_route_first_station
    @stations[show_message('Выберете начальную станцию', true)]
  end

  def create_route_last_station
    @stations[show_message('Выберете конечную станцию', true)]
  end
end
