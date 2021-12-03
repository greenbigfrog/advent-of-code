SIZE = 12
file = "input.txt"
input = File.readlines(file)

def do_something(input)
    map = {}
    map["0"] = Array.new(SIZE, 0)
    map["1"] = Array.new(SIZE, 0)

    input.each do |l|
        l.split("")[..-2].each_with_index do |num, i|
            map[num][i] += 1
        end
    end
    map
end

map = do_something(input)

out = 0
SIZE.times do |i|
    if map["0"][i] < map["1"][i]
        out = out | 1
    end
    out = out << 1
end
out = out >> 1
epsi = out ^ (1 << SIZE) - 1
puts "Gamma: #{out} Epsilon: #{epsi} Result: #{out * epsi}"

# ----------------------------------------------------------------

oxygen = input.dup
SIZE.times do |i|
    map = do_something(oxygen)
    break if oxygen.size == 1
    check = nil
    if map["0"][i] <= map["1"][i]
        check = "1"
    else
        check = "0"
    end
    oxygen = oxygen.reject do |l|
        true if l.split("")[i] != check
    end
end


co = input.dup
SIZE.times do |i|
    map = do_something(co)
    break if co.size == 1
    check = nil
    if map["0"][i] > map["1"][i]
        check = "1"
    else
        check = "0"
    end
    co = co.reject do |l|
        true if l.split("")[i] != check
    end
end

puts "oxygen: #{oxygen.first.rstrip} CO2: #{co.first.rstrip} life support rating: #{oxygen.first.to_i(2) * co.first.to_i(2)}"
