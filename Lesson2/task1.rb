require 'date'

month_hash = {}

(1..12).each do |month|
  date = Date.new(2018, month, -1)
  month_hash[date.strftime("%B")] = date.day

  # Можно и тут сразу вывести)
  # if date.day == 30
  #   puts date.strftime("%B")
  # end
end

month_hash.each do |key, value|
  puts "В #{key} #{value} дней" if value == 30
end

