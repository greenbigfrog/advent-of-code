file = File.readlines("input.txt")

MAP = {"(" => ")", "{" => "}", "[" => "]", "<" => ">"}.freeze

PART2_SCORES = {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4
}

score = []

part2_scores = []

file.each do |line|
    stack = []
    discard = false
    line.rstrip.split("").each do |char|
        if MAP[stack.last] == char
            stack.pop
        elsif MAP.values.include?(char)
            score << char
            discard = true
            break
        else
            stack << char
        end
    end

    unless discard
        missing = []
        stack.reverse.each do |x|
            missing << MAP[x]
        end
        
        s = 0
        missing.each do |x|
            s = s * 5
            s += PART2_SCORES[x]
        end

        part2_scores << s
    end
end

SCORES = {
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137
}.freeze

part1 = SCORES.map { |k, v| score.count(k) * v }.sum
puts "Part 1: #{part1}"

part2 = part2_scores.sort[part2_scores.size / 2]
puts "Part 2: #{part2}"
