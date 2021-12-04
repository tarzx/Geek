def get_position(instructions)
  aim = 0
  position = { x: 0, y: 0 }
  instructions.each do |inst|
    move = inst.split(" ")
    unit = move[1].to_i

    case move[0]
    when "forward"
      position[:x] += unit
      position[:y] += aim * unit
    when "down"
      aim += unit
    when "up"
      aim -= unit
    end
  end

  return position
end

#---------Test---------#
input = ["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"]

result = get_position(input)
puts "Postiton: #{result[:x]}, #{result[:y]}"
puts "Multiply final horizontal position by final depth: #{result[:x] * result[:y]}"

#----------------------#

lines = Array.new
File.open('d2_input.txt').each { |line| lines << line.strip }

result = get_position(lines)
puts "Postiton: #{result[:x]}, #{result[:y]}"
puts "Multiply final horizontal position by final depth: #{result[:x] * result[:y]}"
