struct Time::Span
  def +(other : Sleep)
    self + other.span
  end

  def >(other : Sleep)
    self > other.span
  end
end

struct Time
  def succ
    self + 1.minute
  end
end

class Sleep
  getter start_time : Time
  getter end_time : Time

  def initialize(@start_time, @end_time)
  end

  def span
    @end_time - @start_time
  end

  def +(other : Time::Span)
    other + span
  end

  def +(other : Sleep)
    other.span + span
  end

  def >(other : Time::Span)
    span > other
  end

  def >(other : Sleep)
    span > other.span
  end

  def self.zero
    new(Time.now, Time.now)
  end
end

class Guard
  setter asleep : Array(Sleep) = Array(Sleep).new
  getter id : Int32

  def initialize(@id)
  end

  def sleep(time : Sleep)
    @asleep << time
  end

  def total_sleep
    @asleep.sum
  end

  def get_list_of_minutes_with_frequence
    list = Array(Int32).new(60, 0)
    @asleep.each do |s|
      (s.start_time...s.end_time).to_a.each do |time|
        list[time.minute] += 1
      end
    end
    list
  end

  def average_asleep
    list = get_list_of_minutes_with_frequence
    get_index_of_max(list)
  end

  def max_frequent_minute_with_frequency
    list = get_list_of_minutes_with_frequence
    get_index_of_max_with_value(list)
  end

  def >(other : Guard)
    total_sleep > other.total_sleep
  end

  def ==(other)
    @id == other.id
  end

  def_hash(@id)
end

def get_index_of_max(array)
  get_index_of_max_with_value(array)[0]
end

def get_index_of_max_with_value(array)
  max = 0
  prev = 0
  array.each_with_index do |x, y|
    if x > prev
      max = y
      prev = x
    end
  end
  {max, array[max]}
end

class Guards
  getter list : Hash(Int32, Guard) = Hash(Int32, Guard).new

  def sleep(id, time)
    id = id.not_nil!.to_i32
    @list[id] = Guard.new(id) unless @list[id]?
    @list[id].sleep(time.not_nil!)
  end

  def most_sleep
    res = @list.max_by { |_, val| val }
    res[1]
  end
end

def parse_data_string(input : Array(String))
  ordered = Array(Tuple(Time, String)).new
  input.each do |line|
    # [1518-03-27 00:58] wakes up
    a = line.split(']', remove_empty: true)
    log_time = Time.parse_utc(a[0].lchop('['), "%F %H:%M")
    ordered << {log_time, a[1]}
  end
  ordered.sort! { |a, b| a[0] <=> b[0] }

  guards = Guards.new
  guard = nil
  awake_till = nil
  ordered.each do |entry|
    m = entry[1].match(/#(?<id>\d+)|(?<wakes>wakes up)|(?<asleep>falls asleep)/)
    raise "error" if m.nil?
    guard = m["id"] if m["id"]?
    awake_till = entry[0] if m["asleep"]?
    span = Sleep.new(awake_till, entry[0]) if awake_till
    guards.sleep(guard, span) if m["wakes"]?
  end
  guards
end
