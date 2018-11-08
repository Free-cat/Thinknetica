purchases = {}
all_total = 0

loop do
  puts "Введите название товара"
  name = gets.chomp
  break if name == 'стоп'

  puts "Введите цену товара"
  cost = gets.chomp.to_f
  puts "Введите количество товара"
  quantity = gets.chomp.to_i

  purchases[name] = {cost: cost, quantity: quantity, total: cost * quantity}

  # Тут если не храним в хеше
  # purchases[name] = {cost: cost, quantity: quantity}
end

purchases.each_with_index do |(key, value), index|
  total_row = value[:total]
  puts "#{index + 1}: #{key.to_s}, количество: #{value[:quantity]}, цена: #{value[:cost]}, сумма: #{total_row}"

  # Тут если не храним в хеше
  # total_row = value[:quantity] * value[:cost]
  # puts "#{index}: #{key.to_s}, количество: #{value[:quantity]}, цена: #{value[:cost]}, сумма: #{value[:quantity] * value[:cost]}"

  all_total += total_row
end

puts "Всего покупок на сумму #{all_total}"
