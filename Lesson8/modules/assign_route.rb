module AssignRoute
  private

  def assign_route
    puts '============Назначение маршрута поезду============'
    show_all_train
    train = show_message('Выберете поезд', true)
    if @trains[train]
      show_assign_route(train)
    else
      puts 'Указанный поезд не найден!'
    end
  end

  def show_assign_route(train)
    puts "Список маршрутов:\n"
    show_route
    route = show_message('Выберете маршрут', true)
    if @routes[route]
      @trains[train].route = @routes[route]
      puts 'Маршрут установлен!'
    else
      'Маршрут не найден'
    end
  end
end
