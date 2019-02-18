require_relative 'lib/object'
require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
Dir['./modules/*.rb'].each(&method(:require))

class Main
  include AssignRoute
  include AttachWagon
  include CreateTrain
  include LoadWagons
  include ManageRoute
  include Menu
  include MoveTrain
  include SeedData
  include ShowStations

  def initialize
    @stations = []
    @trains = []
    @routes = []
    seed_data
  end

  def seed_data
    @stations += create_seed_stations
    @trains += create_seed_cargo
    @trains += create_seed_passenger
    @routes << Route.new('new_route', @stations[0], @stations[5])
  end

  private

  def show_train
    @trains.each_with_index do |train, index|
      next if train.current_station.nil?

      puts "[#{index}] Поезд #{train.id} - " \
           "количество вагон #{train.wagons.size}" \
           "Производитель #{train.company_name}"
    end
  end

  def show_all_train
    @trains.each_with_index do |train, index|
      puts "[#{index}] Поезд #{train.id} - " \
           "количество вагон #{train.wagons.size}" \
           "Производитель #{train.company_name}"
    end
  end

  def show_stations
    @stations.each_with_index do |station, index|
      puts "[#{index}] Станция #{station.name}"
      puts 'Поезда на станции' unless station.trains.empty?

      station.train_block &show_station_train_block
    end
  end

  def show_station_train_block
    proc do |train|
      puts "- #{train.id}, #{train.type}, #{train.wagons.count}"
      puts 'Вагоны в поезде:'
      train.wagon_block &show_station_wagon_block
    end
  end

  def show_station_wagon_block
    proc do |wagon, index|
      puts "- - #{index}, #{wagon.type}, " \
           "Свободно: #{wagon.free_capacity}, " \
           "Занято: #{wagon.occupied_capacity}"
    end
  end

  def show_route
    puts "Список доступных маршрутов:\n"
    @routes.each_with_index do |route, index|
      puts "[#{index}] Маршрут #{route.name}"
    end
  end

  def show_message(message, int = false)
    print "#{message}\n"
    input = gets.chomp
    return nil if input.empty?

    int ? input.to_i : input
  end

  def retry?(error)
    puts "Ошибка ввода: #{error.message}"
    puts 'Чтобы попробовать снова введите r'
    gets.chomp == 'r'
  end
end

Main.new.start
