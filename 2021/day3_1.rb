def count_bit(list)
  bit_length = list.first.length
  count_bit = [Array.new(bit_length, 0), Array.new(bit_length, 0)]
  list.each do |rate|
    rate.chars.each_with_index do |bit, i|
      count_bit[bit.to_i][i] += 1
    end
  end

  return count_bit
end

def find_most_common(count_bit)
  mcb = ""
  count_bit.first.each_with_index do |pos, i|
    mcb << (pos > count_bit.last[i] ? "0" : "1")
  end

  return mcb.to_i(2)
end

def find_least_common(count_bit)
  lcb = ""
  count_bit.first.each_with_index do |pos, i|
    lcb << (pos < count_bit.last[i] ? "0" : "1")
  end

  return lcb.to_i(2)
end

#---------Test---------#
input = ["00100", "11110", "10110", "10111", "10101", "01111", "00111", "11100", "10000", "11001", "00010", "01010"]

result = count_bit(input)
mcb = find_most_common(result)
lcb = find_least_common(result)
puts "Most: #{mcb}, Least: #{lcb}, Multiply: #{mcb * lcb}"

#----------------------#

lines = Array.new
File.open('d3_input.txt').each { |line| lines << line.strip }

result = count_bit(lines)
mcb = find_most_common(result)
lcb = find_least_common(result)
puts "Most: #{mcb}, Least: #{lcb}, Multiply: #{mcb * lcb}"
