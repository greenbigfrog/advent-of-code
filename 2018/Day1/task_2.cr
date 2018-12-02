START = Time.now

input = File.read_lines("input.txt")
input = input.map { |x| x.to_i32 }

a = 0
old_frequencies = Set{0}
continue = true

input.cycle.each do |x|
  a += x
  if old_frequencies.includes?(a)
    puts "The result is #{a}. (Took #{(Time.now - START).total_milliseconds} ms)"
    break
  end
  old_frequencies << a
end
