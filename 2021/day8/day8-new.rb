input = File.readlines("example.txt")

sum = 0
input.each do |line|
    l = line.split('|')

    dict = {}
    numbers = l[0].split(' ')

    n = numbers.map { |x| x.split('') }.flatten

    seven = numbers.select { |x| x.length == 3 }.map { |x| x.split('') }.flatten
    one = numbers.select { |x| x.length == 2 }.map { |x| x.split('') }.flatten

    dict[(seven - one).first] = 'a'

    ('a'..'g').each do |letter|
        count = n.count(letter)
        # d: 7
        # g: 7
        case count
        when 4 then dict[letter] = 'e'
        when 6 then dict[letter] = 'b'
        when 8 then dict[letter] = 'c' unless dict[letter] == 'a'
        when 9 then dict[letter] = 'f'
        end
    end

    puts dict
    # exit

    l[1].split(' ').each_with_index do |n, i|
        translated = n.split('').map do |x|
            dict[x]
        end.sort
        
        num = MAP[translated] * 10**(3 - i)
        sum += num
    end
end

puts sum