module ShowStations
  private

  def show_stations_with_train
    puts 'Список станций и поездов на станции'
    show_stations
    station_index = show_message('Выберете станцию', true)
    return if station_index.nil?

    station = @stations[station_index]
    print_station_with_train(station)
  end

  def print_station_with_train(station)
    if station
      puts "Список поездов на станции #{station.name}:"
      station.all_train.each { |train| puts train.id.to_s }
    else
      puts 'Неправильно указан индекс станции'
    end
  end
end
