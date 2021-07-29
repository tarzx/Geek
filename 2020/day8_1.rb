def read_instruction(input)
  return input.map { |item| { op: item.split(" ").first, value:  item.split(" ").last.to_i } }
end

def calculate(inst) 
  history = []
  index = 0

  accumulator = 0
  while !history.include?(index) && index >=0 && index < inst.length
    history.push(index)

    case inst[index][:op]
      when "nop" then
        index += 1
      when "acc" then
        accumulator += inst[index][:value]
        index += 1
      when "jmp" then
        index += inst[index][:value]
    end

    # puts "acc: #{accumulator} index: #{index}"
  end

  return accumulator
end

#---------Test---------#
input = ["nop +0", "acc +1", "jmp +4", "acc +3", "jmp -3", "acc -99", "acc +1", "jmp -4", "acc +6"]

# inst = read_instruction(input)
# puts "Accumulator: #{calculate(inst)}"
#----------------------#

lines = Array.new
File.open('d8_input.txt').each { |line| lines << line.strip }

inst = read_instruction(lines)
puts "Accumulator: #{calculate(inst)}"


