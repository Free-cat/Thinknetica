DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def year_is_vis?(year)
  (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)
end

puts "Введите число"
day = gets.chomp.to_i
puts "Введите месяц"
month = gets.chomp.to_i
puts "Введите год"
year = gets.chomp.to_i

DAYS_IN_MONTH[2] = 29 if year_is_vis?(year)

puts "#{day}.#{month}.#{year} это #{DAYS_IN_MONTH[1..month - 1].sum} день с начала года"
