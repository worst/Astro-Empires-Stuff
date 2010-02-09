f = File.open(ARGV[0])
r = /[aA-zZ ]+([0-9]+)[ ]([aA-zZ]+[ aA-zZ]+) at[ aA-zZ]/

hash = {}
f.lines.each do |l|
  matches = l.split("\t")[1].match(r)
  next if matches.nil?
  
  caps = matches.captures
  if hash[caps[1]].nil?
    hash[caps[1]] = caps[0].to_i
  else
    hash[caps[1]] += caps[0].to_i
  end
end

f.close
puts
puts "="*50
puts "Visible production from credits page:"
hash.each_pair {|k, v| puts "#{k}, #{v}"}
puts "="*50
puts