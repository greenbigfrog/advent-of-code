input = File.read_lines("input.txt").first.split(',').map(&.to_i)
stop = false

input[1] = 12
input[2] = 2

pos = 0
loop do
  op = input[pos]
  if op == 99
    stop = true
    break
  end
  first = input[input[pos + 1]]
  second = input[input[pos + 2]]
  output = input[pos + 3]

  puts "Before: #{input}"
  case op
  when 1 then input[output] = first + second
  when 2 then input[output] = first * second
  end

  pos += 4
  puts "Pos: #{pos}"
  puts "After: #{input}"
end

puts input.join(',')
