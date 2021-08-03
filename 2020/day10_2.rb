def set_of_dif_1(list)
  device = list.max + 3
  sorted_list = list.push(0).sort.reverse

  last_adp = device # charging outlet
  set_dif_1 = []
  sorted_list.each do |adp|
    if last_adp - adp == 3 && adp != 0
      set_dif_1.push([])
    elsif last_adp - adp == 1
      set_dif_1.last.push(last_adp)
      set_dif_1.last.push(adp)
    end

    last_adp = adp
  end

  return set_dif_1.select { |x| x.any? }.map { |x| x.uniq }
end

def cal_total(list)
  set = set_of_dif_1(list)

  total = 1
  set.each do |s|
    if s.length == 3
      total *= 2
    elsif s.length == 4
      total *= 4
    elsif s.length == 5
      total *= 7
    elsif s.length == 6
      total *= 13
    elsif s.length == 7
      total *= 16
    end
    # As checked max dif 1 length is 5
  end

  return total
end

# def count_possibility(list)
#   return 1 if list.length == 1

#   total = 0
#   list.each_with_index do |adp, j|
#     if j > 0 && list[j] - list[0] <= 3
#       total += count_possibility(list[j..list.length - 1])
#     end
#   end

#   return total
# end

# def cal_total(list)
#   device = list.max + 3
#   sorted_list = list.push(0).push(device).sort
#   return count_possibility(sorted_list)
# end

#---------Test---------#
input1 = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
puts "the total number of arrangements: #{cal_total(input1)}"

input2 = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3]
puts "the total number of arrangements: #{cal_total(input2)}"
#----------------------#

lines = Array.new
File.open('d10_input.txt').each { |line| lines << line.strip.to_i }

puts "the total number of arrangements: #{cal_total(lines)}"
