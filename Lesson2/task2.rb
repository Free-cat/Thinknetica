index = 10
arr = []

puts "While"
while index <= 100 do
  arr << index
  index += 5
end
puts arr

puts "Step"
arr2 = (10..100).step(5).to_a
puts arr2
