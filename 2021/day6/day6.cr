require "benchmark"

def solve(days)
    # text = "3,4,3,1,2"
    text = File.read("input.txt")
    list = Hash(Int64, Int64).new(0)
    text.split(",").each{ |x| list[x.to_i64] = list[x.to_i64] + 1 }

    days.times do |i|
        # puts "Day #{i}: #{list}"
        count = 0_i64
        (0_i64..8_i64).each do |x|
            if x == 0
                count = list[x]
            else
                # puts "Moving #{x} to #{(x - 1) % 8}"
                list[((x - 1) % 8).to_i64] = list[x]
            end
        end
        # puts "Count: #{count}"
        list[6_i64] = list[6] + count
        list[8_i64] = count        
    end

    # puts list.values.sum
end

# part1
solve(80)

# part2
solve(256)

Benchmark.ips do |x|
    x.report("something") do
        solve(256)
    end
end