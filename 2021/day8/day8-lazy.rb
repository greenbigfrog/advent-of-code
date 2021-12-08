# 2: "1"
# 3: "7"
# 4: "4"
# 7: "8"

# "7"-"1"=aaaa

file = File.readlines("input.txt")

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

sum = 0
file.each do |line|
    dict = {}
    l = line.split('|')
    nums = l[0].split(" ")

    seven = nums.select { |x| x.length == 3 }.map { |x| x.split('') }.flatten
    one = nums.select { |x| x.length == 2 }.map { |x| x.split('') }.flatten
    eight = nums.select { |x| x.length == 7 }.map { |x| x.split('') }.flatten
    four = nums.select { |x| x.length == 4 }.map { |x| x.split('') }.flatten

    # aaaa can be determined by going 7 - 1
    a = seven - one
    dict["a"] = a

    e_or_g = (eight - four - seven).uniq
    b_or_d = (four - one).uniq

    x = nums.select { |y| y.length == 5 }.map { |y| y.split('') }.flatten
    o = x.select { |y| x.count(y) == 1 }
    b = o - e_or_g
    dict["b"] = b
    
    d = b_or_d - b
    dict['d'] = d

    e = e_or_g.difference(e_or_g - o)
    dict["e"] = e
    g = e_or_g - e
    dict["g"] = g

    x = nums.select { |y| y.length == 6 }.map { |y| y.split('') }.flatten
    o = x.select { |y| x.count(y) == 2 }
    c = o - d - e
    dict['c'] = c.uniq

    f = one - c
    dict['f'] = f

    dict = dict.transform_values { |y| y.first }.invert

    l[1].split(' ').each_with_index do |n, i|
        translated = n.split('').map do |x|
            dict[x]
        end.sort
        
        num = MAP[translated] * 10**(3 - i)
        sum += num
    end
end

puts sum