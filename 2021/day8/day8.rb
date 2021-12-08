input = File.readlines("example.txt")

count = 0
input.each do |x|
    x.rstrip.split(" | ")[1].split(" ").each do |num|
        if num.length == 2 or num.length == 3 or num.length == 4 or num.length == 7
            count += 1
        end
    end
end

puts "Part 1: #{count}"

MAP = {
    ["a", "b", "c", "e", "f", "g"] => 0,
    ["c", "f"] => 1,
    ["a", "c", "d", "e", "g"] => 2,
    ["a", "c", "d", "f", "g"] => 3,
    ["b", "c", "d", "f"] => 4,
    ["a", "b", "d", "f", "g"] => 5,
    ["a", "b", "d", "e", "f", "g"] => 6,
    ["b", "c", "f"] => 7,
    ["a", "b", "c", "d", "e", "f", "g"] => 8,
    ["a", "b", "c", "d", "f", "g"] => 9
}

sum = 0
input.each do |x|
    dictionary = Hash.new(Array.new())
    x.split(" ").each do |num|
        if num.length == 2 or num.length == 3 or num.length == 4 or num.length == 7
            match = nil
            MAP.each do |m, _|
                match = m if m.size == num.length
            end
            num.split("").each do |x|
                dictionary[x] += match
            end
        end
    end

    dict = {}
    while dictionary.size > 0
        original = nil
        res = nil
        max = 0
        dictionary.each do |orig, possible|
            possible.each do |x|
                c = possible.count(x)
                if c > max
                    res = x
                    max = c
                    original = orig
                end
            end
        end

        dictionary = dictionary.map do |key, value|
            value.delete(res)
            [key, value]
        end.to_h

        dict[original] = res
        dictionary.delete(original)
    end

    puts "dict: #{dict}"


    test, number = x.split(" | ")

    result = 0
    number.rstrip.split(" ").each_with_index do |num, i|
        converted = num.split("").map { |x| dict[x] }.sort
        puts "Converted: #{converted}"
        res = MAP[converted]
        result += res * (10**(3-i))
    end
    puts result
    sum += result
end

puts sum