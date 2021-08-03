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

def cal_total(set)
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
  end

  return total
end

#---------Test---------#
input1 = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]

set1 = set_of_dif_1(input1)
puts "the total number of arrangements: #{cal_total(set1)}"

input2 = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3]

set2 = set_of_dif_1(input2)
puts "the total number of arrangements: #{cal_total(set2)}"
#----------------------#

lines = Array.new
File.open('d10_input.txt').each { |line| lines << line.strip.to_i }

set = set_of_dif_1(lines)
puts "the total number of arrangements: #{cal_total(set)}"
