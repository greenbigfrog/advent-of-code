START = Time.now

input = File.read_lines("input.txt")
chars = ""
continue = true
input.each do |outer_line|
  break unless continue
  input.each do |inner_line|
    break unless continue
    next if inner_line == outer_line
    count = 0
    inner_line.each_char_with_index do |char, index|
      break unless continue
      if outer_line[index] == char
        count += 1
      end
      if count >= 25
        char = inner_line.chars - outer_line.chars
        chars = inner_line.delete(char[0])
        continue = false
      end
    end
  end
end

puts "The common characters are #{chars.inspect}. (Took #{(Time.now - START).total_milliseconds} ms)"
