START = Time.now

input = File.read_lines("input.txt")

class Vector
  getter x : Int32
  getter y : Int32

  def initialize(@x, @y)
  end

  def ==(other)
    @x == other.x && @y == other.y
  end

  def_hash(@x, @y)
end

def parse_data_string(input : Array(String))
  data = Hash(Int32, Tuple(Vector, Vector)).new

  regex = /#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<width>\d+)x(?<height>\d+)/

  input.each do |line|
    m = regex.match(line)
    data[m["id"].to_i32] = {Vector.new(m["x"].to_i32, m["y"].to_i32),
                            Vector.new(m["width"].to_i32, m["height"].to_i32)} if m
  end
  data
end

def check_overlap(data : Hash(Int32, Tuple(Vector, Vector)))
  covered = Hash(Vector, Set(Int32)).new

  data.each do |id, tuple|
    vec = tuple[0]
    size = tuple[1]
    (vec.x + 1..(vec.x + size.x)).each do |x|
      (vec.y + 1..(vec.y + size.y)).each do |y|
        vector = Vector.new(x, y)
        if covered[vector]?
          covered[vector] << id
        else
          covered[vector] = [id].to_set
        end
      end
    end
  end

  delete = Set(Int32).new
  pre_choice = Set(Int32).new
  covered.each_value do |y|
    if y.size > 1
      y.each { |id| delete << id }
    end
    next if y.any? { |id| delete.includes?(id) }
    pre_choice << y.first
  end

  pre_choice.each do |id|
    next if delete.includes?(id)
    return id
  end
end

puts "Claim ##{check_overlap(parse_data_string(input))} has no overlap with any of the other claims. (Took #{(Time.now - START).total_milliseconds} ms)"
