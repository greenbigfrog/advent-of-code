file = File.readlines("example.txt")

map = Array.new
file.each_with_index do |line, i|
    map[i] = line.rstrip.split("").map { |x| x.to_i }
end

lines = []
pp map