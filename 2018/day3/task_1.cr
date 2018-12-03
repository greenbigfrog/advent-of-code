START = Time.now

input = File.read_lines("input.txt")

class Vector
  getter x : Int32
  getter y : Int32

  def initialize(@x, @y)
  end

  def_hash(@x, @y)
end

def parse_data_string(input : Array(String))
  data = Hash(String, Tuple(Vector, Vector)).new

  regex = /#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<width>\d+)x(?<height>\d+)/

  input.each do |line|
    m = regex.match(line)
    data[m["id"]] = {Vector.new(m["x"].to_i32, m["y"].to_i32),
                     Vector.new(m["width"].to_i32, m["height"].to_i32)} if m
  end
  data
end

def check_overlap(data : Hash(String, Tuple(Vector, Vector))) : Set(Vector)
  covered = Set(Vector).new
  overlap = Set(Vector).new

  data.each_value do |tuple|
    vec = tuple[0]
    size = tuple[1]
    (vec.x + 1..(vec.x + size.x)).each do |x|
      (vec.y + 1..(vec.y + size.y)).each do |y|
        vector = Vector.new(x, y)
        if covered.includes?(vector)
          overlap << vector
        else
          covered << vector
        end
      end
    end
  end
  overlap
end

puts "#{check_overlap(parse_data_string(input)).size} inches are within two or more claims. (Took #{(Time.now - START).total_milliseconds} ms)"
