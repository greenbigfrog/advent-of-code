input = "abc

a
b
c

ab
ac

a
a
a
a

b"

input = File.read("input.txt")

sum = 0
input.split("\n\n").each do |group|
  sum += group.split("\n").join("").split("").uniq.size
end

puts "Part 1: #{sum}"

sum = 0
input.split("\n\n").each do |group|
  g = group.split("\n")
  a = g[0].split("")
  g[1..-1].each do |any|
    arr = any.split("")
    a = a & arr
  end
  sum += a.size
end

puts "Part 2: #{sum}"

