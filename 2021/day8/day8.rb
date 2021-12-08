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

# Removes given letter from all arrays in the values of dict
def remove_letter(dict, letter)
  dict.transform_values do |value|
    value.map! { |x| x.delete(letter); x }
    value.reject!(&:empty?)
    value.uniq! # TODO: Why do we need this?

    # If we reach a point where we deleted the last option for a given letter, we reached a point of no return
    raise "Value is empty after removing #{letter}" if value.empty? && dict.size > 1

    value
  end
end

def get_dict(text)
  dictionary = Hash.new { [] }
  text.split(' ').each do |num|
    next unless num.length == 2 || num.length == 3 || num.length == 4 || num.length == 7

    match = nil
    MAP.each do |m, _|
      if m.size == num.length
        match = m.dup
        break
      end
    end

    num.split('').each do |x|
      dictionary[x] = dictionary[x] << match
    end
  end

  dict = {}
  did_nothing = false

  backup = dictionary.transform_values { |v| v.dup }.dup

  until dictionary.any? { |_, v| v.empty? } || dictionary.empty?
    # puts "dictionary: #{dictionary}"
    # puts "dict: #{dict}"

    letter = nil

    begin
      res = nil
      dictionary.each do |mapping, possible_groups|
        res = mapping
        if possible_groups.size == 1
          letter = possible_groups.first.first
          dict[mapping] = letter
          break
        end

        possible_groups.each do |g|
          if g.size == 1 && dict[mapping].nil?
            letter = g.first
            dict[mapping] = letter
            break
          elsif g.size == 2 && dict[mapping].nil?
            letter = g[Random.rand(2)]
            dict[mapping] = letter
            break
          else
            did_nothing = true
          end
        end

        if letter
          did_nothing = false
          break
        end
      end

      if did_nothing
        key, value = dictionary[Random.rand(dictionary.size)]
        i = Random.rand(value.size)
        raise "Did nothing. Error in selecting" if value[i].size == 1

        letter = value[i][Random.rand(value[i].size)]
        dict[key] = letter
      end

      dictionary = remove_letter(dictionary, letter)
      dictionary.delete(res)
    rescue StandardError => e
      puts "Error #{e}. Retrying"
      dictionary = backup.transform_values { |v| v.dup }.dup
    end
  end
  dict
end

def translate(dict, number)
  result = 0
  number.rstrip.split(' ').each_with_index do |num, i|
    converted = num.split('').map { |x| dict[x] }.sort.to_a
    puts "Converted: #{converted.inspect}"
    res = MAP[converted]
    puts "Res: #{res}"
    result += res * (10**(3 - i))
  end
  result
end

def call(text)
  begin
    dict = get_dict(text)
    puts "dict: #{dict}"

    _, number = text.split(' | ')

    res = translate(dict, number)
  rescue StandardError => e
    puts "Error during translation: #{e}"
    return nil
  end
  res
end

sum = 0
input.each do |line|
  puts "Retrying line" until (r = call(line))
  sum += r
end

puts sum
