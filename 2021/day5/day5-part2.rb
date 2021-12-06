class MyRange
    def initialize(first, last)
        @first, @last = first, last
    end

    def each(&block)
        if @first > @last
            i = @first
            while i >= @last
                yield i
                i -= 1
            end
        else
            Range.new(@first, @last).each(&block)
        end
    end

    def size
        [@first - @last, @last - @first].max
    end

    def to_a
        out = []
        self.each do |x|
            out << x
        end
        out
    end
end

class Line
    def initialize(x1, x2, y1, y2)
        @x1, @x2, @y1, @y2 = x1, x2, y1, y2
        @x = MyRange.new(@x1, x2)
        @y = MyRange.new(@y1, @y2)
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
        else
            @x.size.times do |i|
                yield @x.to_a[i], @y.to_a[i]
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