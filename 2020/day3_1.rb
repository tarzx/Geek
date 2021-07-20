lines = Array.new
File.open('d3_input.txt').each { |line| lines << line.strip }

right = 0

x = 0
o = 0
lines.each do |line|
  width = line.length

  p = line[right%width]
  if p == '#' 
    x += 1
  elsif p == '.'
    o += 1
  end

  # line[right%width] = 'X' if line[right%width] == '#'
  # line[right%width] = 'O' if line[right%width] == '.'
  # puts line

  right += 3
end

puts "Tree: #{x}, Open: #{o}"