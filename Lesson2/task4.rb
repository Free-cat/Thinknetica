char_hash = {}

('A'..'Z').each_with_index do |char, index|
  if char =~ /[AEIOU]/
    char_hash[char] = index
  end
end

puts char_hash
