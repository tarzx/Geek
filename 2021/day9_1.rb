def get_map(lines)
  map = Array.new
  lines.each do |line|
    map << line.split("").map(&:to_i)
  end

  # puts "#{map}"
  return map
end

def find_low_points(map)
  low_points = Array.new
  map.each_with_index do |row, i|
    row.each_with_index do |p, j|
      up = down = left = right = 10
      up = map[i-1][j] if i > 0
      down = map[i+1][j] if i < map.size-1
      left = map[i][j-1] if j > 0
      right = map[i][j+1] if j < row.size-1

      # puts "#{up} - #{down} - #{left} - #{right}"
      low_points << { row: i, col: j } if p < up && p < down && p < left && p < right
    end
  end

  puts "#{low_points}"
  return low_points
end

def risk_level(map, low_points)
  sum = 0
  low_points.each do |point|
    row = point[:row]
    col = point[:col]
    sum += map[row][col] + 1
  end

  return sum
end

def cal(lines)
  map = get_map(lines)
  low_points = find_low_points(map)
  result = risk_level(map, low_points)

  return result
end

#---------Test---------#
input = ["2199943210", "3987894921", "9856789892", "8767896789", "9899965678"]

result = cal(input)
puts "The sum of the risk levels of all low points on your heightmap: #{result}"

#----------------------#

lines = Array.new
File.open('d9_input.txt').each { |line| lines << line.strip }

result = cal(lines)
puts "The sum of the risk levels of all low points on your heightmap: #{result}"
