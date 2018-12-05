require "benchmark"

input = File.read_lines("input.txt")

input = ["dabAcCaCBAcCcaDA"]

def delete(array : Array(Char) | Array(Char?))
  puts array.join("")
  copy = Array(Char).new
  prev = ' '
  skip = false
  array.each_with_index do |char, i|
    copy << char
    next unless char.is_a?(Char)
    next prev = char if i == 0
    if prev.downcase == char.downcase
      next skip = false if skip
      if char.lowercase? == prev.lowercase? # check if same case
        skip = false
      else
        copy.pop?
        copy.pop?
        skip = true
      end
    else
      skip = false
    end
    prev = char
  end
  copy
end

def reduce(array : Array(Char))
  loop do
    new_array = delete(array.dup)
    break if new_array == array
    array = new_array
  end
  array
end

def task_1(string : String)
  reduce(string.chars).size
end

def task_2(string : String)
  chars = ('a'..'z').to_a
  chars.min_of do |x|
    puts string
    size = reduce(string.dup.chars.reject { |i| i.downcase == x }).size
    puts "#{x}: #{size}"
    size
  end
end

a = Time.measure do
  b = input[0]
  # task_1(b)
  pp task_2(b)
end
pp a.total_milliseconds

# Benchmark.ips do |x|
#   x.report("First attempt") { reduce(input[0].chars).size }
#   x.report("Second attempt") { reduce_test(input[0].chars).size }
# end
