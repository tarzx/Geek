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

def select_most_common(list, count_bit, bit)
  list.select do |rate| 
    rate[bit] == (count_bit[0][bit] > count_bit[1][bit] ? "0" : "1")
  end
end

def select_least_common(list, count_bit, bit)
  list.select do |rate| 
    rate[bit] == (count_bit[0][bit] > count_bit[1][bit] ? "1" : "0")
  end
end

def oxygen_rate(list)
  bit_length = list.first.length
  for i in 0..bit_length-1
    count_bit = count_bit(list)
    list = select_most_common(list, count_bit, i)
    
    break if list.size == 1
  end

  return list.first.to_i(2)
end

def carbon_rate(list)
  bit_length = list.first.length
  for i in 0..bit_length-1
    count_bit = count_bit(list)
    list = select_least_common(list, count_bit, i)

    break if list.size == 1
  end

  return list.first.to_i(2)
end

#---------Test---------#
input = ["00100", "11110", "10110", "10111", "10101", "01111", "00111", "11100", "10000", "11001", "00010", "01010"]

oxygen = oxygen_rate(input)
carbon = carbon_rate(input)
puts "Oxygen: #{oxygen}, Carbon: #{carbon}, Miltiply: #{oxygen * carbon}"

#----------------------#

lines = Array.new
File.open('d3_input.txt').each { |line| lines << line.strip }

oxygen = oxygen_rate(lines)
carbon = carbon_rate(lines)
puts "Oxygen: #{oxygen}, Carbon: #{carbon}, Miltiply: #{oxygen * carbon}"
