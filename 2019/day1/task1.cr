input = File.read_lines("input.txt")
sum = 0

input.each do |mass|
  sum += (mass.to_i / 3).floor - 2
end
puts sum
