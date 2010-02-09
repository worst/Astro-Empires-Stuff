# sample data file:
#
# Battle Report
# Location  LIND (A07:54:70:20)
# Time  2010-02-05 19:11:07
# Attack Force
# Player  [CR] Anacaona   lvl 60.46
# Fleet Name  tumble 22
# Defensive Force
# Player  [Ni] BlueWolf74727   lvl 57.44
# Fleet Name  Fleet 260 (Destroyed)
# Base  262383
# Start Defenses  100%
# End Defenses  0%
# Command Centers 11
# Commander Devin Tauros (Research 10)
# 
# Attack Force
# Unit  Start Quant.  End Quant.  Power Armour  Shield
# Fighters  121584  120030  4.8 4.8 0
# Corvette  4244  3467  9.6 9.6 0
# Destroyer 5388  5000  17.2  19.2  0
# Cruiser 8271  8142.7  51.6  57.6  3.9
# 
# Defensive Force
# Unit  Start Quant.  End Quant.  Power Armour  Shield
# Fighters  23  0 7.8 5 0
# Dreadnought 5 0 1874.9  1280  40
# Disruptor Turrets 10  0 384 640 16
# Planetary Shield  5 0 6.6 5120  40
# Planetary Ring  5 0 3276.8  2560  24
# 
# Total cost of units destroyed: 114545 ( Attacker: 64430 ; Defender: 50115 )
# Experience: ( Attacker: +5169 ; Defender: +6028 )
# New debris in space: 66150
# Attacker conquered the base
# Attacker got 19287 credits for pillaging defender's base.
#

data_file = ARGV[0]

attack = true
if !ARGV[1].nil?
 attack = false if ARGV[1].eql?("defend")
end


r_units_destroyed = /Total cost of units destroyed: [0-9]+ \( Attacker: ([0-9]+) ; Defender: ([0-9]+) \)/
r_derbs = /New debris in space: ([0-9]+)/i
r_pillage = /Attacker got ([0-9]+) credits for pillaging defender's base./
r_experience = /Experience: \( Attacker: \+([0-9]+) ; Defender: \+([0-9]+) \)/i

losses = {:attacker => 0, :defender => 0}
derbs = 0
pillage = 0
exp = {:attacker => 0, :defender => 0}

f = File.open(data_file)


matches = f.read.scan(r_units_destroyed)
matches.each do |match|
  losses[:attacker] += match[0].to_i
  losses[:defender] += match[1].to_i
end

f.rewind
matches = f.read.scan(r_derbs)
matches.each do |match|
  derbs += match[0].to_i
end

f.rewind
matches = f.read.scan(r_pillage)
matches.each do |match|
  pillage += match[0].to_i
end

f.rewind
matches = f.read.scan(r_experience)
matches.each do |match|
  exp[:attacker] += match[0].to_i
  exp[:defender] += match[1].to_i
end

puts
puts "=" * 50
puts "Attacker losses: #{losses[:attacker]}"
puts "Defender losses: #{losses[:defender]}"
puts "Derbs: #{derbs}"
puts "Pillage: #{pillage}"

puts "Profits: #{pillage + derbs - losses[:attacker]}"
if !attack
  puts "Ratio: #{losses[:attacker].to_f/losses[:defender].to_f}"
else
  puts "Ratio: #{losses[:defender].to_f/losses[:attacker].to_f}"
end

puts "Return on Investment: #{100.0 * (pillage + derbs - losses[:attacker] - losses[:attacker]).to_f/losses[:attacker].to_f}%"

puts "Attacker XP: #{exp[:attacker]}"
puts "Defender XP: #{exp[:defender]}"

puts "=" * 50
puts

