require "benchmark"

INPUT = File.read_lines("input.txt").map { |x| x.to_i32 }

def find_frequency
  a = 0
  old_frequencies = Set{0}
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

def find_frequency_old
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
  x.report("pre-populate with 0") { find_frequency }
  x.report("don't") { find_frequency_old }
end
