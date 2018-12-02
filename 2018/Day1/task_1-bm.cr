require "benchmark"

INPUT     = File.read_lines("input.txt").map { |x| x.to_i32 }
OLD_INPUT = File.read_lines("input.txt")

def find_frequency
  a = 0
  INPUT.each do |x|
    a += x
  end
end

def find_frequency_old
  a = 0
  OLD_INPUT.each do |x|
    a += x.to_i32
  end
end

Benchmark.ips do |x|
  x.report("find frequency") { find_frequency }
  x.report("convert to int") { find_frequency_old }
end
