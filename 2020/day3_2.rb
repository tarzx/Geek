lines = Array.new
File.open('d3_input.txt').each { |line| lines << line.strip }

path = Array.new

slopes = [ {r: 1, d: 1}, {r: 3, d: 1}, {r: 5, d: 1}, {r: 7, d: 1}, {r: 1, d: 2}]
slopes.each do |slope|
  x = o = 0
  px = py = 0
  while py < lines.length
    line = lines[py]
    width = line.length
    p = line[px%width]
    if p == '#' 
      x += 1
    elsif p == '.'
      o += 1
    end

    # line[px%width] = 'X' if line[px%width] == '#'
    # line[px%width] = 'O' if line[px%width] == '.'
    # puts line

    px += slope[:r]
    py += slope[:d]
  end

  path.push({x: x, o: o})
  puts "Tree: #{x}, Open: #{o}"
end

puts path.map{ |p| p[:x] }.inject(:*)