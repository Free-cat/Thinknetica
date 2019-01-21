require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'


class Main

  def initialize
    @stations = []
    @trains = []
    @routes = []
    test_date
  end

  def test_date
    @stations << s1 = Station.new("station1")
    @stations << s2 = Station.new("station2")
    @stations << s3 = Station.new("station3")
    @stations << s4 = Station.new("station4")
    @stations << s5 = Station.new("station5")
    @stations << s6 = Station.new("station6")

    @trains << ct1 = CargoTrain.new("car-01", 'cargo_train1')
    @trains << ct2 = CargoTrain.new("car-02", 'cargo_train2')
    @trains << ct3 = CargoTrain.new("car-03", 'cargo_train3')
    @trains << pt1 = PassengerTrain.new("pas-01", 'passenger_train1')
    @trains << pt2 = PassengerTrain.new("pas-02", 'passenger_train2')
    @trains << pt3 = PassengerTrain.new("pas-03", 'passenger_train3')

    @routes << route1 = Route.new("new_route", s1, s6)
  end

  def start
    loop do
      show_menu
      case gets.chomp
      when '1' then create_station
      when '2' then create_trains
      when '3' then manage_route
      when '4' then assign_route
      when '5' then attach_wagon_to_train
      when '6' then detach_wagon_of_train
      when '7' then move_train
      when '8' then show_stations_with_train
      when '0' then break
      end
    end
  end

  #будет использовано только в другом методе, в одном классе.
  private
  def create_station#Создавать станции
    puts "============Создание станции============"
    loop do
      begin
        station_name = show_message("Введите название станции или ENTER для завершения")
        break if station_name.nil?
        @stations << Station.new(station_name)
        puts "Станция #{station_name} успешно создана"
      rescue Exception => e
        puts "Ошибка ввода: #{e.message}"
        puts 'Чтобы попробовать снова введите 1'
        retry if gets.chomp.to_i == 1
      end
    end
  end
#Создавать поезда
  def create_trains
    loop do
      puts "============Создание поездов============"
      puts "Выберете тип поезда для создания:\n
      [1] Создавать пассажирский поезд
      [2] Создавать грузовой поезд
      [0] Назад
      "
      train_type = gets.chomp.to_i
      break if train_type.nil? || train_type == 0
      begin
        train_id = show_message("Введите ID поезда в формате (123-ab, abc-ab, abc12) или ENTER для завершения")
        train_company_name = show_message("Введите производителя поезда")
        if train_type == 1
          train = PassengerTrain.new(train_id, train_company_name)
          puts "Пассажирский поезд c номером #{train.id} производителя #{train.company_name} успешно создан"
          @trains << train
        elsif train_type == 2
          train = CargoTrain.new(train_id, train_company_name)
          puts "Товарный поезд c номером #{train.id} производителя #{train.company_name} успешно создан"
          @trains << train
        else
          puts "Ошибка ввода пункта меню"
        end
      rescue Exception => e
        puts "Ошибка ввода: #{e.message}"
        puts 'Чтобы попробовать снова введите 1'
        retry if gets.chomp.to_i == 1
      end
    end
  end
#Добавлять вагоны к поезду
  def attach_wagon_to_train
    loop do
      show_train
      train_index = show_message("Выберете поезд или ENTER для завершения", true)
      break if train_index.nil?
      train = @trains[train_index]
      break if train.nil?

      begin
        wagon_company_name = show_message("Введите производителя вагона или ENTER для завершения")
        if train.type == "cargo"
          wagon = CargoWagon.new(wagon_company_name)
          train.add_wagon(wagon)
          puts "Вагон производителя #{wagon.company_name} прицеплен к поезду #{train.id}"
        elsif train.type == "passenger"
          wagon = PassengerWagon.new(wagon_company_name)
          train.add_wagon(wagon)
          puts "Вагон производителя #{wagon.company_name} прицеплен к поезду #{train.id}"
        end
      rescue Exception => e
        puts "Ошибка ввода: #{e.message}"
        puts 'Чтобы попробовать снова введите 1'
        retry if gets.chomp.to_i == 1
      end
    end
  end
#Отцеплять вагоны от поезда
  def detach_wagon_of_train
    show_train
    train_index = show_message("Выберете поезд", true)
    train = @trains[train_index]
    if train
      train.delete_wagon
      puts "От поезда #{train.id} отцеплён вагон"
    else
      puts "Данный поезд не найден"
    end
  end

  def show_train
    @trains.each_with_index do |train, index|
      puts "[#{index}] Поезд #{train.id} - количество вагон #{train.wagons.size} Производитель #{train.company_name}"
    end
  end

  def show_train_with_route
    @trains.each_with_index do |train, index|
      puts "[#{index}] Поезд #{train.id} - количество вагон #{train.wagons.size} Производитель #{train.company_name}" unless train.current_station.nil?
    end
  end

  def show_stations
    @stations.each_with_index do |station, index|
      puts "[#{index}] Станция #{station.name}"
    end
  end

  def show_route
    puts "Список доступных маршрутов:\n"
    @routes.each_with_index do |route, index|
      puts "[#{index}] Маршрут #{route.name}"
    end
  end
#Создавать маршруты и управлять станциями в нем (добавлять, удалять)
  def manage_route
    loop do
      puts "============Менеджер маршрутами============"
      puts "Выберете действие:\n
      [1] Создавать маршрут
      [2] Управление маршрутом
      [0] Назад
      "
      action_route = gets.chomp.to_i
      break if action_route.nil?
      if action_route == 1
        create_route
      elsif action_route == 2
        puts "============Управление маршрутами============"
        puts "Выберете маршрут:"
        show_route
        route = @routes[show_message("Выберете маршрут:", true)]
        puts "Выберете действие:\n
        [1] Добавить станцию
        [2] Удалить станцию
        [0] Назад
        "
        case gets.chomp
        when '1' then add_station_route(route)
        when '2' then del_station_in_route(route)
        end
      else
        puts "Команда не найдена!"
        return
      end
    end
  end
#Метод для добавления станций в маршрут
  def add_station_route(route)
    show_stations
    station = show_message("Выберете станцию для добавления", true)
    if @stations[station]
      route.add_station(@stations[station])
      puts "Станция успешно добавлена"
    else
      puts "Станция не найдена"
      return
    end
  end
#Метод для удаления станции из маршрута
  def del_station_in_route(route)
    puts "Список станций маршрута #{route.name}"
    route.show_stations
    station = show_message("Выберете станцию для удаления", true)
    return if station.nil?
    if route.delete_station(route.show_stations[station])
      puts "Станция успешно удалена!"
    else
      puts "Неверный индекс"
    end
  end
#Метод для создания маршрута
  def create_route
    if @stations.size > 2
      puts "============Создание нового маршрута============"
      puts "Доступные станции для добавления:"
      show_stations
      begin
        name = show_message("Введите имя маршрута")
        first_station = @stations[show_message("Выберете начальную станцию", true)]
        last_station = @stations[show_message("Выберете конечную станцию", true)]
        @routes << route = Route.new(name, first_station, last_station)
        puts "Маршрут #{name} успешно создан"
      rescue Exception => e
        puts "Ошибка ввода: #{e.message}"
        puts 'Чтобы попробовать снова введите 1'
        retry if gets.chomp.to_i == 1
      end
    else
      puts "Необходимо больше 2-х станций для создание маршрута"
    end
  end
#Метод для ввывода сообщения и возврата переменной, ввёдной пользователем
  def show_message(message, int = false)
    print "#{message}\n"
    input = gets.chomp
    return nil if input.empty?
    int ? input.to_i : input
  end
#Назначать маршрут поезду
  def assign_route
    puts "============Назначение маршрута поезду============"
    show_train
    train = show_message("Выберете поезд",true)
    if @trains[train]
      puts "Список маршрутов:\n"
      show_route
      route = show_message("Выберете маршрут",true)
      if @routes[route]
        @trains[train].route = @routes[route]
        puts "Маршрут установлен!"
      else
        "Маршрут не найден"
      end
    else
      puts "Указанный поезд не найден!"
    end
  end
#Перемещать поезд по маршруту вперед и назад
  def move_train
    puts "============Перемещение поезда по маршруту============"
    show_train_with_route
    train_id = show_message("Выберете поезд для перемещения", true)
    return if train_id.nil?
    train = @trains[train_id]
    if train
      loop do
        puts "Поезд #{train.id} находится на станции #{train.current_station.name}"
        puts "[n] - для перемещения на следующую станцию"
        puts "[p] - для перемещения на предыдущую станцию"
        action = show_message("")
        break if action.nil?
        if action == "n"
          train.station_up
        elsif action == "p"
          train.station_down
        end
      end
    end
  end

  def show_stations_with_train
    puts "Список станций и поездов на станции"
    show_stations
    station_index = show_message("Выберете станцию",true)
    return if station_index.nil?
    station = @stations[station_index]
    if station
      puts "Список поездов на станции #{station.name}:"
      station.all_train.each { |train| puts "#{train.id}"}
    else
      puts 'Неправельно указан индекс станции'
    end
  end
  def show_menu
    puts "============Программа по управлению поездами============"
    puts "\nВыберете действие:\n
    [1] Создавать станцию
    [2] Создавать поезд
    [3] Создать маршрут и управлять станциями в нем
    [4] Назначить маршрут поезду
    [5] Добавить вагон к поезду
    [6] Отцепить вагоны от поезда
    [7] Переместить поезд по маршруту вперед и назад
    [8] Посмотреть список станций и список поездов на станции
    [0] Выход"
  end
end



Main.new.start