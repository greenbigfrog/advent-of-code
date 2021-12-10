file = File.readlines("example.txt")

MAP = {"(" => ")", "{" => "}", "[" => "]", "<" => ">"}.freeze

def get_close(text, lvl)
    puts "lvl: #{lvl}"
    puts "Looking at: #{text}"

    if text.nil? || text.empty?
        puts "Empty"
        return true
    end

    current = text.first
    puts "current: #{current}"

    if MAP[current] == text[1]
        puts "Matched Closing"
        return get_close(text[2..], lvl - 1)
    else
        puts "Unmatched"
        return get_close(text[1..], lvl + 1)
    end
    
end

file.each do |line|
    t = line.rstrip.split("")

    lvl = 0
    x = get_close(t, lvl)
    puts "x: #{x}"
    exit
end