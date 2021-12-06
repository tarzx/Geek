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
  if position[:s] && position[:e]
    for i in (position[:s]..position[:e])
      val = position[:is_horizontal] ? "#{i}|#{position[:static]}" : "#{position[:static]}|#{i}"
      diagram.push val
    end
  end
end

def count_overlap(diagram)
  diagram.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
end

def get_positions(line)
  pos = line.split(" -> ").map{ |pos| get_coordinate(pos) }
  start_point = nil
  end_point = nil
  static = nil
  is_horizontal = true

  if pos[0][:x] > pos[1][:x] && pos[0][:y] == pos[1][:y]
    start_point = pos[1][:x]
    end_point = pos[0][:x]
    static = pos[0][:y]
  elsif pos[1][:x] > pos[0][:x] && pos[0][:y] == pos[1][:y]
    start_point = pos[0][:x]
    end_point = pos[1][:x]
    static = pos[0][:y]
  elsif pos[0][:y] > pos[1][:y] && pos[0][:x] == pos[1][:x]
    start_point = pos[1][:y]
    end_point = pos[0][:y]
    static = pos[0][:x]
    is_horizontal = false
  elsif pos[1][:y] > pos[0][:y] && pos[0][:x] == pos[1][:x]
    start_point = pos[0][:y]
    end_point = pos[1][:y]
    static = pos[0][:x]
    is_horizontal = false
  end

  return { s: start_point, e: end_point, static: static, is_horizontal: is_horizontal }
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

