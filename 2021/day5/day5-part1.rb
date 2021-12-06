class Line
    def initialize(x1, x2, y1, y2)
        @x1, @x2, @y1, @y2 = x1, x2, y1, y2
        @x = Range.new([@x1, @x2].min, [@x1, @x2].max)
        @y = Range.new([@y1, @y2].min, [@y1, @y2].max)
    end

    def each(&block)
        if @x1 == @x2
            @y.each do |y|
                yield @x1, y
            end
        elsif @y1 == @y2
            @x.each do |x|
                yield x, @y1
            end
        end
    end
end

lines = []

File.readlines("input.txt").each do |line|
    m = /(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)/.match(line)
    x1 = m["x1"].to_i
    x2 = m["x2"].to_i
    y1 = m["y1"].to_i
    y2 = m["y2"].to_i
    lines << Line.new(x1, x2, y1, y2)
end

# lines.each do |line|
#     puts line.inspect
# end

size = 1000
map = Array.new(size) { Array.new(size, 0) }

lines.each do |line|
    line.each do |x, y|
        map[x][y] += 1
    end
end

# map.each do |x|
#     puts x.inspect
# end

puts map.map { |x| x.count { |y| y > 1 }}.sum