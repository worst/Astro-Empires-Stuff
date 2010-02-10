f = File.open(ARGV[0])
r = /[aA-zZ ]+([0-9]+)[ ]([aA-zZ]+[ aA-zZ]+) at[ aA-zZ]/

r2 = /Production of ([0-9]+) ([aA-zZ ]+)/i

hash = {}
f.lines.each do |l|
  splits = l.split("\t")
  next if splits.length < 3
  matches = l.split("\t")[1].match(r)
  next if matches.nil?

  caps = matches.captures
  hash[caps[1]] ||= 0
  
  hash[caps[1]] += caps[0].to_i
end

f.rewind

matches = f.read.scan(r2)

matches.each do |match|
  hash[match[1]] ||= 0

  hash[match[1]] += match[0].to_i
end

puts
puts "="*50
puts "Visible production:"
hash.each_pair {|k, v| puts "#{k}, #{v}"}
puts "="*50
puts
