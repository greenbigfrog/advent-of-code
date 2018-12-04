require "./classes"
# require "benchmark"

input = File.read_lines("input.txt")

def part_1(input : Array(String))
  guards = parse_data_string(input)
  most_sleep = guards.most_sleep
  "Guard: ##{most_sleep.id}: Minute where the guard sleeps most often: #{most_sleep.average_asleep}"
end

def part_2(input : Array(String))
  guards = parse_data_string(input)

  id = nil
  time = nil
  max_frequency = 0
  guards.list.each_value do |guard|
    minute, frequency = guard.max_frequent_minute_with_frequency
    if frequency > max_frequency
      id = guard.id
      time = minute
      max_frequency = frequency
    end
  end
  "Guard: #{id}: Most often frequent at minute #{time} with a frequency of #{max_frequency}"
end

a = Time.measure do
  puts part_1(input)
  puts part_2(input)
end
pp a.total_milliseconds

# Benchmark.ips do |x|
#   x.report("Part 1") { part_1(input) }
#   x.report("Part 2") { part_2(input) }
# end
