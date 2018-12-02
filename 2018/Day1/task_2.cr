START = Time.now

input = File.read_lines("input.txt")
input = input.map { |x| x.to_i32 }

a = 0
old_frequencies = Set{0}
continue = true

while continue == true
  input.each do |x|
    a += x
    if old_frequencies.includes?(a)
      puts "The result is #{a}. (Took #{(Time.now - START).total_milliseconds} ms)"
      continue = false
      break
    end
    old_frequencies << a
  end
end
