
file = "example.txt"
input = File.readlines(file)

numbers = input.first.split(",")

boards = []

input[2..].slice_after("\n").each do |board|
    columns = []
    board.each do |r|
        break if r == "\n"
        row = []
        r.split("\s").each do |number|
            row << number
        end
        columns << row
    end
    boards << columns
end

def sum(b)
    sum = 0
    b.each do |column|
        column.each do |row|
            sum += row.to_i
        end
    end
    sum
end

def mark(boards, number)
    boards.map do |columns|
        columns.map do |row|
            row.map do |num|
                num == number ? nil : num
            end
        end
    end
end

def check_row(columns)
    [0..4].each do |i|
        return true if columns.all? { |x| x[i].nil? }
    end
    false
end

def check(boards)
    boards.each do |b|
        r = check_row(b)
        puts "Empty row" if r
        c = b.any? { |x| x.compact.empty? }
        puts "Empty column" if c
        if c || r
            puts "#{b} has empty row or column"
            return sum(b)
        else
            return false
        end
    end
end

numbers.each do |number|
    boards = mark(boards, number)
    puts boards.inspect
    c = check(boards)
    if c
        puts "sum is #{c}, last number was #{number}"
        puts c * number.to_i
        exit
    end
end
