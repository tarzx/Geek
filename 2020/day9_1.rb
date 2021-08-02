def check_valid(list, index, preamble)
  return true if index < preamble

  sub = list[index - preamble..index - 1]
  # puts "Check: #{list[index]} in #{sub}"
  return sum_from_list(sub, list[index])
end

def sum_from_list(list, exp)
  remain = list.map { |item| exp - item }
  remain.each do |value|
    return true if list.include?(value)
  end

  return false
end

def first_invalid(list, preamble)
  index = 0
  while index < list.length
    if !check_valid(list, index, preamble)
      return list[index]
    end
    index += 1
  end

  return nil
end

#---------Test---------#
input = [35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277, 309, 576]

# preamble = 5
# puts "Invalid: #{first_invalid(input, preamble)}"

#----------------------#

lines = Array.new
File.open('d9_input.txt').each { |line| lines << line.strip.to_i }

preamble = 25
puts "Invalid: #{first_invalid(lines, preamble)}"
