purchases = {}
all_total = 0

loop do
  puts 'Введите название товара'
  name = gets.chomp
  break if name == 'стоп'

  puts 'Введите цену товара'
  cost = gets.chomp.to_f
  puts 'Введите количество товара'
  quantity = gets.chomp.to_i

  purchases[name] = { cost: cost, quantity: quantity, total: cost * quantity }
end

purchases.each_with_index do |(key, value), index|
  puts "#{index + 1}: #{key}, количество: #{value[:quantity]}, цена: #{value[:cost]}, сумма: #{value[:total]}"
  all_total += value[:total]
end

puts "Всего покупок на сумму #{all_total}"
