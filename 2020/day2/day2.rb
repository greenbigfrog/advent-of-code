input = []
File.readlines("input.txt").each do |x|
# File.readlines("sample.txt").each do |x|
  input << x
end

# Part 1
count = 0
input.each do |a|
  if r = a.match(/(?<min>\d*)-(?<max>\d*) (?<char>\w): (?<password>\w*)/)
    c = r[:password].count(r[:char])
    if (c >= r[:min].to_s.to_i && c <= r[:max].to_s.to_i) then
      count = count + 1
    end
  end
end
puts count

# Part 2
count = 0
input.each do |a|
  if r = a.match(/(?<min>\d*)-(?<max>\d*) (?<char>\w): (?<password>\w*)/)
    if (r[:password].to_s[r[:min].to_s.to_i - 1] == r[:char].to_s) ^ (r[:password].to_s[r[:max].to_s.to_i - 1] == r[:char].to_s) then
      count = count + 1
    end
  end
end
puts count
 
