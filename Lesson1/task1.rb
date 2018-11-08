puts "Каков ваш рост?"
height = gets.chomp.to_i
puts "Как вас зовут?"
name = gets.chomp

ideal_weight = height - 110
if ideal_weight > 0
  puts "#{name}, Ваш идеальный вес #{ideal_weight}"
else
  puts "#{name}, У вас и так все хорошо)"
end