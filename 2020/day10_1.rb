def joits_dif(list)
  device = list.max + 3
  sorted_list = list.push(device).sort

  counter = { dif1: 0, dif3: 0 }
  last_adp = 0 # charging outlet
  sorted_list.each do |adp|
    if adp - last_adp == 3
      counter[:dif3] += 1
    elsif adp - last_adp == 1
      counter[:dif1] += 1
    end

    last_adp = adp
  end

  return counter
end

#---------Test---------#
input1 = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]

counter1 = joits_dif(input1)
puts "Difference of 1: #{counter1[:dif1]}, Difference of 3: #{counter1[:dif3]}"

input2 = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3]

counter2 = joits_dif(input2)
puts "Difference of 1: #{counter2[:dif1]}, Difference of 3: #{counter2[:dif3]}"
#----------------------#

lines = Array.new
File.open('d10_input.txt').each { |line| lines << line.strip.to_i }

counter = joits_dif(lines)
puts "Difference of 1: #{counter[:dif1]}, Difference of 3: #{counter[:dif3]}"
puts "Multiplied: #{counter[:dif1] * counter[:dif3]}"
