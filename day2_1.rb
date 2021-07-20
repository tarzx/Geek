lines = Array.new
File.open('d2_input.txt').each { |line| lines << line }

list = lines.map do |line|  
  s = line.split(" ")
  r = s[0].split("-")
  {
    pwd: s[2],
    con: s[1].tr(":", ""),
    min: r[0].to_i,
    max: r[1].to_i
  }
end

valid_count = 0
invalid_count = 0

list.each do |item|
  count = item[:pwd].count(item[:con])
  if count >= item[:min] && count <= item[:max]
    valid_count += 1
  else
    invalid_count += 1
  end
end

puts "valid: #{valid_count}, invalid: #{invalid_count}"
