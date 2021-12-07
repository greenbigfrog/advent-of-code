t = File.read("input.txt")
# t = "16,1,2,0,4,2,7,1,2,14"
input = t.split(',').map { |x| x.to_i }

sorted = input.sort
puts "Offset: #{offset = sorted[input.size/2]}"
sum = sorted.map { |x| (x - offset).abs }.sum
puts sum


# Part 2
# This only works semi well, and is more or less just bruteforcing the solution,
# except skipping to a sensible area to check
exp = 100000000000 - 1
last = 100000000000
while exp < last
    last = exp
    puts "offset: #{offset}"
    exp = sorted.map do |x| 
        x = (x - offset).abs 
        r = (x * (x+1))/2
        # puts "x: #{x} r: #{r}"
        r
    end.sum
    puts "exp: #{exp}"
    offset += 1
end
puts exp