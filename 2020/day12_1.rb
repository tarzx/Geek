def go(info, inst)
  action = inst.slice(0)
  unit = inst[1..-1].to_i
  
  if ['L', 'R'].include?(action)
    directions = ['N', 'E', 'S', 'W']
    cur_inx = directions.index(info[:direction])

    if action == "L"
      facing = directions[(cur_inx - unit/90) % 4]
    else
      facing = directions[(cur_inx + unit/90) % 4]
    end

    info[:direction] = facing
  else
    # pos[0] + N / - S
    # pos[1] + E / - W
    facing = action == "F" ? info[:direction] : action
    case facing
      when "N"
        info[:pos][0] += unit
      when "S"
        info[:pos][0] -= unit
      when "E"
        info[:pos][1] += unit
      when "W"
        info[:pos][1] -= unit
    end
  end

  return info
end

def distance(instuctions, info)
  instuctions.each do |inst|
    info = go(info, inst)
    puts "#{inst} - #{info}"
  end

  return info[:pos][0].abs + info[:pos][1].abs
end

#---------Test---------#
input = ["F10", "N3", "F7", "R90", "F11"]

# info = { pos: [0, 0], direction: "E" }
# puts "Distance: #{distance(input, info)}"

#----------------------#

lines = Array.new
File.open('d12_input.txt').each { |line| lines << line.strip }

info = { pos: [0, 0], direction: "E" }
puts "Distance: #{distance(lines, info)}"
