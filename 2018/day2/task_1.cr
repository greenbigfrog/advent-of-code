START = Time.now

input = File.read_lines("input.txt")

count = Hash(Char, Int32).new

amount_2 = 0
amount_3 = 0
input.each do |x|
  count.clear

  x.each_char do |char|
    current = count[char]? ? count[char] : 0
    count[char] = 1 + current
  end

  check_2 = true
  check_3 = true
  count.each_value do |num|
    case num
    when 2
      if check_2
        amount_2 += 1
        check_2 = false
      end
    when 3
      if check_3
        amount_3 += 1
        check_3 = false
      end
    end
  end
end

puts "The checksum is #{amount_2 * amount_3}. (Took #{(Time.now - START).total_milliseconds} ms)"
