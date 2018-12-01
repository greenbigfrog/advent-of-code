START = Time.now

input = File.read_lines("input.txt")

a = 0
input.each do |x|
  a += x.to_i32
end

puts "The result is #{a}. (Took #{(Time.now - START).total_milliseconds} ms)"
