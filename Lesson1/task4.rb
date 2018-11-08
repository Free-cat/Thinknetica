puts "Введите 1 коэф."
a = gets.chomp.to_f
puts "Введите 2 коэф."
b = gets.chomp.to_f
puts "Введите 3 коэф."
c = gets.chomp.to_f

d = (b**2) - (4*a*c)


case
when d == 0
  x1 = -b / (2 * a)
  puts "Один корень, X = #{x1}, d = #{d}"
when d > 0
  d_coub = Math.sqrt(d)
  x1 = (-b + d_coub)/2 * a
  x2 = (-b - d_coub)/2 * a
  puts "Два корня, X1 = #{x1}, X2 = #{x2}, d = #{d}"
else
  puts "Уравнение действительных решений не имеет d = #{d}"
end