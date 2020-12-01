orig_input = File.read_lines("input.txt").first.split(',').map(&.to_i)

verb = 2
noun = 12

stop = false
while stop == false
  verb += 1
  noun += 1
  input = orig_input
  input[1] = verb
  input[2] = noun

  pos = 0
  loop do
    op = input[pos]
    if op == 99
      break
    end
    first = input[input[pos + 1]]
    second = input[input[pos + 2]]
    output = input[pos + 3]

    case op
    when 1 then input[output] = first + second
    when 2 then input[output] = first * second
    end

    pos += 4
    puts input[0]
    exit if input[0] == 19690720
  end
end
