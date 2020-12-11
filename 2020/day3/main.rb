
lines = File.readlines("input.txt")
# lines = File.readlines("sample.txt")
map = Array.new(lines.size) { Array.new(lines[0].size, false) }

lines.each_with_index do |line, x|
  line.chomp.each_char.each_with_index do |i, y|
    if i == "#"
      map[x][y] = true
    end
  end
end

def slope(y_jump, x_jump, lines, map)
  count = 0
  y = 0
  x = 0
  loop do
    x += x_jump
    y += y_jump
    if x >= lines.size
      break
    end
    if map[x][y % lines[0].chomp.size] == true
      count += 1
    end
  end
  count
end


puts a = slope(1, 1, lines, map)
puts b = slope(3, 1, lines, map)
puts c = slope(5, 1, lines, map)
puts d = slope(7, 1, lines, map)
puts e = slope(1, 2, lines, map)
puts
puts a * b * c * d * e
