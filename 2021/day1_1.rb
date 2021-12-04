def count_larger(list)
  count = 0
  previous = nil
  list.each do |deep|
    count += 1 if previous && compare(previous, deep)
    previous = deep
  end

  return count
end

def compare(val1, val2)
  return val2 > val1
end

#---------Test---------#
input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

result = count_larger(input)
puts "There are #{result} measurements that are larger than the previous measurement"

#----------------------#

lines = Array.new
File.open('d1_input.txt').each { |line| lines << line.strip.to_i }

result = count_larger(lines)
puts "There are #{result} measurements that are larger than the previous measurement"
