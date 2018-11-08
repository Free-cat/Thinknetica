DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def year_is_vis?(year)
  year_is_vis = false
  if (year % 4 == 0) && (year % 100 != 0)
    year_is_vis = true
  elsif year % 400 == 0
    year_is_vis = true
  end

  year_is_vis
end

def days_in_month(month, year)
  return 29 if month == 2 && year_is_vis?(year)
  DAYS_IN_MONTH[month]
end

puts "Введите число"
day = gets.chomp.to_i
puts "Введите месяц"
month = gets.chomp.to_i
puts "Введите год"
year = gets.chomp.to_i

result_count = 0
(1..month - 1).each do |month_in_range|
  result_count += days_in_month(month_in_range, year)
end
result_count += day

puts "#{day}.#{month}.#{year} это #{result_count} день с начала года"






