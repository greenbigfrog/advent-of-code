size = 5
file = "example.txt"
input = File.readlines(file)
map = {}
map["0"] = Array.new(12, 0)
map["1"] = Array.new(12, 0)
input.each do |l|
    l.split("")[..-2].each_with_index do |num, i|
        map[num][i] += 1
    end
end

out = 0
size.times do |i|
    if map["0"][i] < map["1"][i]
        out = out | 1
    end
    out = out << 1
end
out = out >> 1
epsi = out ^ (1 << size) - 1
puts "Gamma: #{out} Epsilon: #{epsi} Result: #{out * epsi}"

final = input.dup
input.each_with_index do |l, index|
    stop = false
    size.times do |i|
        next if stop
        check = nil
        if map["0"][i] > map["1"][i]
            check = "0"
        else
            check = "1"
        end
        puts "looking in index #{i}"
        if l.split("")[i] == check
            nil
        else
            puts "throwing out #{l}"
            final[index] = nil
            stop = true
        end
    end
end

puts final.uniq.inspect
