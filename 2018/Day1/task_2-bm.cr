require "benchmark"

INPUT = File.read_lines("input.txt").map { |x| x.to_i32 }

def find_frequency
  a = 0
  old_frequencies = Set(Int32).new
  continue = true

  while continue == true
    INPUT.each do |x|
      a += x
      if old_frequencies.includes?(a)
        continue = false
        break
      end
      old_frequencies << a
    end
  end
end

Benchmark.ips do |x|
  x.report("find first old frequency") { find_frequency }
end
