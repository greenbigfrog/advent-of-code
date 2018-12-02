require "benchmark"

INPUT = File.read_lines("input.txt").map { |x| x.to_i32 }

def find_frequency
  a = 0
  old_frequencies = Set{0}
  continue = true

  INPUT.cycle.each do |x|
    a += x
    if old_frequencies.includes?(a)
      break
    end
    old_frequencies << a
  end
end

Benchmark.ips do |x|
  x.report("Find first common frequency") { find_frequency }
end
