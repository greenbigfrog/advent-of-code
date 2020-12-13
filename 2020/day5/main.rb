sample = [
  "BFFFBBFRRR",
  "FFFBBBFRRR",
  "BBFFBBFRLL"
]

# input = sample
# input = ["FBFBBFFRLR"]

input = File.readlines("input.txt")

ids = []
max = 0


input.each do |i|
  low = 0
  high = 127
  row = 0
  low_c = 0
  high_c = 7
  col = 0
  i.each_char do |c|
    half = (high - low + 1) / 2
    half_c = (high_c - low_c + 1) / 2
    case c
    when "F" 
      high -= half
      row = low
    when "B" 
      low += half
      row = high
    when "L"
      high_c -= half_c
      col = low_c
    when "R"
      low_c += half_c
      col = high_c
    end
    # puts "Low: #{low_c} High: #{high_c}"
  end
  id = row * 8 + col
  # puts "Row: #{row} Col: #{col} ID: #{id}"

  ids << id

  max = id if id > max
end

puts "Part 1: #{max}"

ids.sort!
ids.each_with_index do |x, i|
  if ids[i-1] == x-2
    puts "Part 2: #{x - 1}"
  end
end
