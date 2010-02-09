# Unit  Total Unit Cost Total Cost  Speed Weapon  Modified Power/Armour (Shield)
# Fighters  13919 5 69595   Laser 5 / 5
# Bombers 3000  10  30000   Missiles  9 / 5
# Heavy Bombers 1680  30  50400   Plasma  22 / 10
# Ion Bombers 0 60  0   Ion 20.4 / 10 (2)
# Corvette  53888 20  1077760 18  Laser 10 / 10
# Recycler  60599 30  1817970 11.25 Laser 5 / 5
# Destroyer 24849 40  993960  11.25 Plasma  17.6 / 20
# Frigate 21081 80  1686480 11.25 Missiles  27 / 30
# Ion Frigate 0 120 0 11.25 Ion 23.8 / 30 (2)
# Scout Ship  60  40  2400  25.2  Laser 2.5 / 5
# Outpost Ship  9 100 900 6.3 Laser 5 / 10
# Cruiser 7960  200 1592000 8.4 Plasma  52.8 / 60 (4)
# Carrier 2077  400 830800  8.4 Missiles  27 / 60 (4)
# Heavy Cruiser 1062  500 531000  6.3 Plasma  105.6 / 120 (8)
# Battleship  80  2000  160000  6.3 Ion 285.6 / 320 (20)
# Fleet Carrier 611 2500  1527500 6.3 Ion 108.8 / 240 (16)
# Dreadnought 38  10000 380000  4.2 Photon  1209.6 / 1280 (40)
# Titan 0 50000 0 2.1 Disruptor 4422.6 / 5120 (60)
# Leviathan 1 200000  200000  2.1 Photon  16000 / 16500 (80)

f = File.open(ARGV[0])

units = {}
unit_hanger = {
                "Fighters" => -1,
                "Bombers" => -1,
                "Heavy Bombers" => -2,
                "Ion Bombers" => -2,
                "Frigate" => 4,
                "Ion Frigate" => 4,
                "Cruiser" => 4,
                "Carrier" => 60,
                "Heavy Cruiser" => 8,
                "Battleship" => 40,
                "Fleet Carrier" => 400,
                "Dreadnought" => 200,
                "Titan" => 1000,
                "Leviathan" => 4000,
                "Death Star" => 10000
              }
                
r = /([aA-zZ ]+)[\s]([0-9]+)/
f.lines.each {|l| units["#{l.match(r).captures[0]}"] = l.match(r).captures[1].to_i}

# open space (including caps)
open_space = 0
unit_hanger.each_pair {|k, v| open_space += v * (units[k] ||= 0)}

# open space (no caps)
open_space_no_caps = 0
# #reject is same as #delete_if but works on and returns a copy
unit_hanger_no_caps = unit_hanger.reject {|k, v| v >= 200 && !k.eql?("Fleet Carrier")}
unit_hanger_no_caps.each_pair {|k, v| open_space_no_caps += v * (units[k] ||= 0)}

# hanger space (including caps)
hanger_space = 0
unit_hanger.delete_if {|k, v| v < 0}
unit_hanger.each_pair {|k, v| hanger_space += v * (units[k] ||= 0)}

# hanger space (no caps)
hanger_space_no_caps = 0
unit_hanger_no_caps.delete_if {|k, v| v < 0}
unit_hanger_no_caps.each_pair {|k, v| hanger_space_no_caps += v * (units[k] ||= 0)}

puts
puts "="*50
puts "Max Hanger Space: #{hanger_space_no_caps}"
puts "Open Hanger Space: #{open_space_no_caps}"
puts "-"*50
puts "Hanger Space Including Capital Ships"
puts "Max Hanger Space: #{hanger_space}"
puts "Open Hanger Space: #{open_space}"
puts "="*50
puts
