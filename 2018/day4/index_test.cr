require "benchmark"

Benchmark.ips do |x|
  x.report("gbf") { get_index_of_max }
  x.report("builtin") { builtin }
end

def get_index_of_max
  max = 0
  prev = 0
  get_new_array.each_with_index do |x, y|
    if x > prev
      max = y
      prev = x
    end
  end
  max
end

def builtin
  a = get_new_array
  a.index(a.max)
end

def get_new_array
  input = Array(Int32).new(1000000)
  1000000.times do
    input << rand(100000000)
  end
  input
end
