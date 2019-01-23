module Menu
  def start
    loop do
      show_menu
      case gets.chomp
      when '1' then create_stations
      when '2' then create_trains
      when '3' then manage_route
      when '4' then assign_route
      when '5' then attach_wagon_to_train
      when '6' then detach_wagon_of_train
      when '7' then move_train
      when '8' then show_stations_with_train
      when '9' then load_wagons
      else break
      end
    end
  end

  private

  def show_menu
    puts '============Программа по управлению поездами============'
    puts 'Выберете действие:'
    menu_item.map { |k, v| puts "[#{k}] - #{v}" }
  end

  def menu_item
    { '1' => 'Создавать станцию',
      '2' => 'Создавать поезд',
      '3' => 'Создать маршрут и управлять станциями в нем',
      '4' => 'Назначить маршрут поезду',
      '5' => 'Добавить вагон к поезду',
      '6' => 'Отцепить вагоны от поезда',
      '7' => 'Переместить поезд по маршруту вперед и назад',
      '8' => 'Посмотреть список станций и список поездов на станции',
      '9' => 'Загружать вагоны',
      '0' => 'Выход' }
  end
end
