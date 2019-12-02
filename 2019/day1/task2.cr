def calc_fuel(mass)
  (mass / 3).floor - 2
end

input = File.read_lines("input.txt")
fuel = 0

input.each do |mass|
  fuel_mass = mass.to_i
  while (tmp_fuel = calc_fuel(fuel_mass)) > 0
    fuel += tmp_fuel
    fuel_mass = tmp_fuel
  end
end

puts fuel
