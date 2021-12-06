def count_larger(list)
  count = 0
  previous = nil
  list.each do |deep|
    count += 1 if previous && compare(previous, deep)
    previous = deep
  end

  return count
end

def draw(lines)
  diagram = Array.new
  lines.each do |line|
    position = get_positions(line)
    # puts "#{line} - #{position}"

    add_line(diagram, position)
  end

  # puts "#{diagram}"
  process_diagram = count_overlap(diagram)
  # puts "#{process_diagram}"

  overlap = process_diagram.select { |k, v| v > 1 }
  return overlap.size
end

def add_line(diagram, position)
  point_x = position[:sx]
  point_y = position[:sy]
  while point_x <= position[:ex]
    diagram.push "#{point_x}|#{point_y}"

    point_x += 1 unless point_x == position[:ex] && point_y != position[:ey]
    if point_y != position[:ey]
      point_y = position[:is_up] ? point_y + 1 : point_y - 1
    end
  end
end

def count_overlap(diagram)
  diagram.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
end

def get_positions(line)
  pos = line.split(" -> ").map{ |pos| get_coordinate(pos) }
  sx = nil
  ex = nil
  sy = nil
  ey = nil
  is_up = true

  if pos[0][:x] >= pos[1][:x]
    sx = pos[1][:x]
    ex = pos[0][:x]
    sy = pos[1][:y]
    ey = pos[0][:y]
    is_up = pos[0][:y] >= pos[1][:y]
  elsif pos[0][:x] < pos[1][:x]
    sx = pos[0][:x]
    ex = pos[1][:x]
    sy = pos[0][:y]
    ey = pos[1][:y]
    is_up = pos[1][:y] >= pos[0][:y]
  end

  return { sx: sx, ex: ex, sy: sy, ey: ey, is_up: is_up }
end

def get_coordinate(position)
  co = position.split(",")
  return { x: co[0].to_i, y: co[1].to_i }
end

#---------Test---------#
input = ["0,9 -> 5,9", "8,0 -> 0,8", "9,4 -> 3,4", "2,2 -> 2,1", 
  "7,0 -> 7,4", "6,4 -> 2,0", "0,9 -> 2,9", "3,4 -> 1,4", "0,0 -> 8,8", "5,5 -> 8,2"]

result = draw(input)
puts "At #{result} points do at least two lines overlap"
#----------------------#

lines = Array.new
File.open('d5_input.txt').each { |line| lines << line.strip}

result = draw(lines)
puts "At #{result} points do at least two lines overlap"

