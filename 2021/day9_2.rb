def get_map(lines)
  map = Array.new
  lines.each do |line|
    map << line.split("").map(&:to_i)
  end

  # puts "#{map}"
  return map
end

def get_area(map)
  areas = Array.new
  map.each_with_index do |row, i|
    row.each_with_index do |p, j|
      if p < 9
        area = mark(map, i, j)
        areas << { area: area, row: i, col: j } if area > 0
      end
    end
  end

  # puts "#{areas}"
  return areas
end

def mark(map, row, col)
  count = 1
  map[row][col] = 10

  # up
  if row > 0 && map[row-1][col] < 9
    count += mark(map, row-1, col)
  end
  # left
  if col > 0 && map[row][col-1] < 9
    count += mark(map, row, col-1)
  end
  # rigth
  if col < map[0].size-1 && map[row][col+1] < 9
    count += mark(map, row, col+1)
  end
  # down
  if row < map.size-1 && map[row+1][col] < 9
    count += mark(map, row+1, col)
  end

  return count
end

def get_result(areas)
  sort_area = areas.map{ |a| a[:area] }.sort.reverse
  return sort_area.take(3).inject(:*)
end

def cal(lines)
  map = get_map(lines)
  areas = get_area(map)
  result = get_result(areas)

  return result
end

#---------Test---------#
input = ["2199943210", "3987894921", "9856789892", "8767896789", "9899965678"]

result = cal(input)
puts "Multiply together the sizes of the three largest basins?: #{result}"

#----------------------#

lines = Array.new
File.open('d9_input.txt').each { |line| lines << line.strip }

result = cal(lines)
puts "Multiply together the sizes of the three largest basins?: #{result}"
