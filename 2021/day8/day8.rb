# frozen_string_literal: true

input = File.readlines('input.txt')

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
  %w[a c f] => 7,
  %w[a b c d e f g] => 8,
  %w[a b c d f g] => 9
}.freeze

# Removes given letter from all arrays in the values of dict
def remove_letter(dict, letter)
  dict.transform_values do |value|
    value.map! { |x|
      x.delete(letter)
      x
    }
    value.reject!(&:empty?)
    value.uniq! # TODO: Why do we need this?

    # If we reach a point where we deleted the last option for a given letter, we reached a point of no return
    raise "Value is empty after removing #{letter}" if value.empty? && dict.size > 1

    value
  end
end

def get_dict(text)
  # 1. Split text into numbers, add groups of possible translations for letter to dictionary
  dictionary = Hash.new { [] }
  split = text.split(' ')
  split.delete('|')
  split.each do |num|
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

  backup = dictionary.transform_values(&:dup).dup

  # 2. Delete keys from dictionary until empty. Move translations to dict
  until dictionary.any? { |_, v| v.empty? } || dictionary.empty?
    letter = nil

    begin
      res = nil
      dictionary.each do |mapping, possible_groups|
        res = mapping

        # If only 1 letter left as possiblity
        possible_groups.each do |g|
          if g.size == 1
            letter = g.first
            dict[mapping] = letter
            break
          end
        end
        break if letter
      end

      unless letter
        dictionary.each do |mapping, possible_groups|
          res = mapping
          # If only 2 letters left as possiblity
          possible_groups.each do |g|
            if g.size == 2
              letter = g[Random.rand(2)]
              dict[mapping] = letter
              break
            end
          end

          break if letter
        end
      end

      # If only 3 or more letters left as possiblity
      unless letter
        i = Random.rand(dictionary.keys.first.size)
        original = dictionary.keys[i]
        res = original
        possible_group = dictionary.values[i].first
        letter = possible_group[Random.rand(possible_group.size)]
        dict[original] = letter
      end

      raise "No letter" unless letter

      dictionary = remove_letter(dictionary, letter)
      dictionary.delete(res)
    rescue StandardError => e
      # puts "Error #{e}. Undoing"

      dictionary = backup.transform_values(&:dup).dup
    end
  end
  dict
end

def translate(dict, number)
  result = 0
  number.rstrip.split(' ').each_with_index do |num, i|
    converted = num.split('').map { |x| dict[x] }.sort.to_a
    res = MAP[converted]
    result += res * (10**(3 - i))
  end
  result
end

def call(text)
  begin
    dict = get_dict(text)

    _, number = text.split(' | ')

    res = translate(dict, number)
  rescue StandardError => e
    # puts "Error during translation of #{number}: #{e}"
    return nil
  end
  res
end

sum = 0
input.each do |line|
  # puts "Retrying line #{line}" 
  nil until (r = call(line))
  sum += r
end

puts sum
