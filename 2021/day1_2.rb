def sum_window(list)
  window_list =  Array.new
  window = Array.new(3, nil)
  list.each do |deep|
    window[0] = window[1]
    window[1] = window[2]
    window[2] = deep

    unless window.include?(nil)
      window_list << window.inject(:+)
    end
  end
  
  return window_list
end

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

window = sum_window(input)
result = count_larger(window)
puts "There are #{result} measurements that are larger than the previous measurement"

#----------------------#

lines = Array.new
File.open('d1_input.txt').each { |line| lines << line.strip.to_i }

window = sum_window(lines)
result = count_larger(window)
puts "There are #{result} measurements that are larger than the previous measurement"
