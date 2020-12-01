a = Time.measure do
  hash = Hash(Int32, Set(Int32)).new
  10000.times do |i|
    hash[i] = Set.new([1003, 3352])
  end
end
pp a.total_milliseconds
