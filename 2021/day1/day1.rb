input = []
File.readlines("input.txt").each do |x|
  input << x.to_i
end


# Part 1
def math(input)
  count = 0
  input.each_with_index do |x, i|
    count += 1 if x > input[i-1]
  end
  count
end
puts "Part 1: #{math(input)}"

# Part 2
summed = []
input.each_with_index do |x, i|
  summed << x + input[i-1] + input[i-2]
end
puts "Part 2: #{math(summed)}"