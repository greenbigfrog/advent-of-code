t = File.read("input.txt")
# t = "16,1,2,0,4,2,7,1,2,14"
input = t.split(',').map { |x| x.to_i }

sorted = input.sort
puts "Offset: #{offset = sorted[input.size/2]}"
sum = sorted.map { |x| (x - offset).abs }.sum
puts "Part 1: #{sum}"


# Part 2
offset = sorted.sum / sorted.size
puts "Offset: #{offset}"
exp = sorted.map do |x| 
    x = (x - offset).abs 
    (x * (x+1))/2
end.sum
puts "Part 2: #{exp}"