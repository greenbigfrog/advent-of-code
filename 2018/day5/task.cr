require "benchmark"

input = File.read_lines("input.txt")

# input = ["dabAcCaCBAcCcaDA"]

DIFF = ('A' - 'a').abs

def task_1(data : String | Array(Char))
  if data.is_a?(String)
    array = data.chars
  else
    array = data
  end

  i = 0
  while i < (array.size - 1)
    if (array[i + 1] - array[i]).abs == DIFF
      array.delete_at(i, 2)
      i -= 1 if i > 0
      i -= 1 if i > 0
    end
    i += 1
  end
  array.size
end

def task_2(string : String)
  chars = ('a'..'z').to_a
  chars.min_of do |x|
    test = string.gsub(/#{x}/i, "")
    task_1(test) - 2
  end
end

a = Time.measure do
  b = input[0]
  pp task_1(b)
  pp task_2(b)
end
pp a.total_milliseconds

# Benchmark.ips do |x|
#   x.report("part_1") { task_1(input[0]) }
#   x.report("part_2") { task_2(input[0]) }
# end
