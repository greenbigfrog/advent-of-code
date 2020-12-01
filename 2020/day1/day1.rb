input = []
File.readlines("input.txt").each do |x|
# File.readlines("sample.txt").each do |x|
  input << x.to_i
end

# Part 1
input.each do |a|
  input.each do |b|
    if a + b == 2020
      puts a * b
      # exit
    end
  end
end

# Part 2
input.each do |a|
  input.each do |b|
    input.each do |c|
      if a + b + c == 2020
        puts a * b * c
        exit
      end
    end
  end
end
