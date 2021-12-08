# we can make use of each digit having a distinct amount (of sum of occurances of given signal),
# and existing once in each input

DIGIT_SUMS = {
  42 => 0,
  17 => 1,
  34 => 2,
  39 => 3,
  30 => 4,
  37 => 5,
  41 => 6,
  25 => 7,
  49 => 8,
  45 => 9,
}

file = File.read_lines("input.txt")

sum = 0
file.each do |line|
  input, result = line.split(" | ")

  dict = Hash(String, Int16).new { 0_i16 }
  input.split(" ").each { |y| y.split("").each { |x| dict[x] += 1 } }

  result.split(" ").each_with_index do |res, i|
    s = 0
    res.split("").each { |x| s += dict[x] }

    sum += (DIGIT_SUMS[s] * (10 ** (3 - i)))
  end
end

puts sum
