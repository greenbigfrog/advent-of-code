
def solve(days)
    # text = "3,4,3,1,2"
    text = File.readlines("input.txt").first
    list = Hash.new(0)
    text.split(",").each{ |x| list[x.to_i] = list[x.to_i] + 1 }

    days.times do |i|
        puts "Day #{i}: #{list}"
        count = 0
        (0..8).each do |x|
            if x == 0
                count = list[x]
            else
                puts "Moving #{x} to #{(x - 1) % 8}"
                list[(x - 1) % 8] = list[x]
            end
        end
        puts "Count: #{count}"
        list[6] = list[6] + count
        list[8] = count        
    end

    puts list.values.sum
end

# part1
solve(80)

# part2
solve(256)