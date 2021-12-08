# frozen_string_literal: true

input = File.readlines('example.txt')

count = 0
input.each do |x|
  x.rstrip.split(' | ')[1].split(' ').each do |num|
    count += 1 if num.length == 2 || num.length == 3 || num.length == 4 || num.length == 7
  end
end

puts "Part 1: #{count}"

MAP = {
  %w[a b c e f g] => 0,
  %w[c f] => 1,
  %w[a c d e g] => 2,
  %w[a c d f g] => 3,
  %w[b c d f] => 4,
  %w[a b d f g] => 5,
  %w[a b d e f g] => 6,
  %w[b c f] => 7,
  %w[a b c d e f g] => 8,
  %w[a b c d f g] => 9
}.freeze

sum = 0
input.each do |line|
  dictionary = Hash.new() { [] }
  line.split(' ').each do |num|
    next unless num.length == 2 || num.length == 3 || num.length == 4 || num.length == 7

    match = nil
    MAP.each do |m, _|
      if m.size == num.length
        match = m
        break
      end
    end

    num.split('').each do |x|
      dictionary[x] += match
    end
  end

  puts dictionary

  dict = {}
  while !dictionary.empty?
    original = nil
    res = nil
    max = 0
    dictionary.each do |orig, possible|
      if possible.size == 1
        original = orig
        res = possible.first
        break
      end

      possible.each do |x|
        c = possible.count(x)
        next unless c > max

        res = x
        max = c
        original = orig
      end
    end

    dictionary = dictionary.map do |key, possible|
      possible.delete(res)
      [key, possible]
    end.to_h

    dict[original] = res
    dictionary.delete(original)
  end

  puts "dict: #{dict}"

  _, number = line.split(' | ')

  result = 0
  number.rstrip.split(' ').each_with_index do |num, i|
    converted = num.split('').map { |x| dict[x] }.sort
    puts "Converted: #{converted}"
    res = MAP[converted]
    result += res.to_i * (10**(3 - i))
  end
  puts result
  sum += result
end

puts sum
