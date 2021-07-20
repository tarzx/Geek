lines = Array.new
File.open('d2_input.txt').each { |line| lines << line }

list = lines.map do |line|  
  s = line.split(" ")
  r = s[0].split("-")
  {
    pwd: s[2],
    con: s[1].tr(":", ""),
    p1: r[0].to_i,
    p2: r[1].to_i
  }
end

valid_count = 0
invalid_count = 0

list.each do |item|
  if item[:p1] <= item[:pwd].length && item[:p2] <= item[:pwd].length 
    if (item[:pwd][item[:p1]-1] == item[:con] && item[:pwd][item[:p2]-1] != item[:con]) || 
      (item[:pwd][item[:p1]-1] != item[:con] && item[:pwd][item[:p2]-1] == item[:con])
      valid_count += 1 
      next
    end
  end

  invalid_count += 1
end

puts "valid: #{valid_count}, invalid: #{invalid_count}"
