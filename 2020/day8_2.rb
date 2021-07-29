def read_instruction(input)
  return input.map { |item| { 
      op: item.split(" ").first, 
      value:  item.split(" ").last.to_i, 
      mark: item.split(" ").first == "acc" 
    } }
end

def calculate(inst) 
  history = []
  index = 0
  changed = false

  accumulator = 0
  while !history.include?(index) && index >= 0 && index < inst.length
    history.push(index)

    case inst[index][:op]
      when "acc" then
        accumulator += inst[index][:value]
        index += 1
      when "jmp", "nop"  then
        if changed || inst[index][:mark]
          if inst[index][:op] == "jmp"
            index += inst[index][:value]
          else 
            index += 1
          end
        else
          changed = true
          inst[index][:mark] = true
          if inst[index][:op] == "nop"
            index += inst[index][:value]
          else 
            index += 1
          end
        end
    end

    # puts "acc: #{accumulator} index: #{index}"
  end

  return { accumulator: accumulator, index: index }
end

def get_accumulator_after_change(inst)
  accumulator = 0
  while inst.select { |item| !item[:mark] }.any?
    result = calculate(inst)
    if result[:index] == inst.length
      accumulator = result[:accumulator]
      break
    end
  end
  return accumulator
end

#---------Test---------#
input = ["nop +0", "acc +1", "jmp +4", "acc +3", "jmp -3", "acc -99", "acc +1", "jmp -4", "acc +6"]

# inst = read_instruction(input)
# accumulator = get_accumulator_after_change(inst)
# puts "Accumulator: #{accumulator}"
#----------------------#

lines = Array.new
File.open('d8_input.txt').each { |line| lines << line.strip }

inst = read_instruction(lines)
accumulator = get_accumulator_after_change(inst)
puts "Accumulator: #{accumulator}"


