def go(info, inst)
  action = inst.slice(0)
  unit = inst[1..-1].to_i

  if action == 'F'
    info[:ship][0] += info[:waypoint][0] * unit
    info[:ship][1] += info[:waypoint][1] * unit
  elsif ['L', 'R'].include?(action)
    turn = 0
    while turn < unit
      if action == "L"
        info[:waypoint][0] *= -1
      else
        info[:waypoint][1] *= -1 
      end
      info[:waypoint][0],info[:waypoint][1] = info[:waypoint][1],info[:waypoint][0]

      turn += 90
    end
  else
    # pos[0] + N / - S
    # pos[1] + E / - W
    case action
      when "N"
        info[:waypoint][0] += unit
      when "S"
        info[:waypoint][0] -= unit
      when "E"
        info[:waypoint][1] += unit
      when "W"
        info[:waypoint][1] -= unit
    end
  end

  return info
end

def distance(instuctions, info)
  instuctions.each do |inst|
    info = go(info, inst)
    puts "#{inst} - #{info}"
  end

  return info[:ship][0].abs + info[:ship][1].abs
end

#---------Test---------#
input = ["F10", "N3", "F7", "R90", "F11"]

# info = { ship: [0, 0], waypoint: [1, 10] }
# puts "Distance: #{distance(input, info)}"

#----------------------#

lines = Array.new
File.open('d12_input.txt').each { |line| lines << line.strip }

info = { ship: [0, 0], waypoint: [1, 10] }
puts "Distance: #{distance(lines, info)}"
