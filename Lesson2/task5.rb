DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def year_is_vis?(year)
  (year % 4).zero? && (year % 100 != 0) || (year % 400).zero?
end

puts "Введите число"
day = gets.chomp.to_i
puts "Введите месяц"
month = gets.chomp.to_i
puts "Введите год"
year = gets.chomp.to_i

DAYS_IN_MONTH[2] = 29 if year_is_vis?(year)
day_number = DAYS_IN_MONTH[1..month - 1].sum + day

puts "#{day}.#{month}.#{year} это #{day_number} день с начала года"
