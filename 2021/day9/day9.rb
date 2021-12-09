file = File.readlines("input.txt")

map = []
file.each_with_index do |line, i|
    map[i] = line.rstrip.split("").map { |x| x.to_i }
end

def check(map, comp, x, y)
    left = x-1 < 0 ? 100 : map[x-1][y].to_i
    right = x+1 >= map.size ? 100 : map[x+1][y].to_i
    row = left > comp && comp < right 
    
    w = map[x]
    above = y-1 < 0 ? 100 : w[y-1].to_i
    below = y+1 >= map.first.size ? 100 : w[y+1].to_i
    column = above > comp && comp < below

    row && column
end

sum = 0
map.size.times do |x|
    map.first.size.times do |y|
        comp = map[x][y]
        if check(map, comp, x, y)
            # puts "added #{x} #{y}: #{comp}"
            sum += comp + 1
        end
    end
end

puts sum