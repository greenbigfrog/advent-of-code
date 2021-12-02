

def part1
    input = File.readlines("input.txt")
    depth = 0
    distance = 0

    input.each do |line|
        l = line.split
        case l[0]
        when "forward" then
            distance += l[1].to_i
        when "down" then
            depth += l[1].to_i
        when "up" then
            depth -= l[1].to_i
        end
    end
    distance * depth
end

puts part1

def part2
    input = File.readlines("input.txt")
    depth = 0
    distance = 0
    aim = 0

    input.each do |line|
        l = line.split
        case l[0]
        when "forward" then
            distance += l[1].to_i
            depth += l[1].to_i * aim
        when "down" then
            aim += l[1].to_i
        when "up" then
            aim -= l[1].to_i
        end
    end
    distance * depth
end

puts part2