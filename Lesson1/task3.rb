puts "Введите 1 сторону треугольника"
a = gets.chomp.to_f
puts "Введите 2 сторону треугольника"
b = gets.chomp.to_f
puts "Введите 3 сторону треугольника"
c = gets.chomp.to_f


if a > b && a > c
  leg1 = b
  leg2 = c
  hyp = a
elsif b > a && b > c
  leg1 = a
  leg2 = c
  hyp = b
else
  leg1 = a
  leg2 = b
  hyp = c
end

equilateral = false #Равносторонний
isosceles = false #Равнобедренный
rectangular = false #Прямоугольный

if leg1 == leg2 && leg2 == hyp
  equilateral, isosceles = true, true
elsif leg1 == leg2 || leg1 == hyp || leg2 == hyp
  if (leg1**2 + leg2**2) == hyp**2
    rectangular, equilateral = true, true
  else
    equilateral = true
  end
elsif (leg1**2 + leg2**2) == hyp**2
  rectangular = true
end

if equilateral && isosceles
  puts "Равносторонний и равнобедренный"
elsif rectangular && equilateral
  puts "Прямоугольный и равнобедренный"
elsif equilateral
  puts "Просто равнобедренный"
elsif rectangular
  puts "Просто Прямоугольный"
else
  puts "НЕ равносторонний, НЕ равнобедренный, НЕ прямоугольный"
end
