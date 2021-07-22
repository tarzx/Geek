def count_answer(group_answers)
  return group_answers.map { |answer| answer.chars }.inject(:&).count
end

#---------Test---------#
puts count_answer(['abc']) #3.
puts count_answer(['a','b','c']) #0.
puts count_answer(['ab','ac']) #1.
puts count_answer(['a','a','a','a']) #1.
puts count_answer(['b']) #1.
#----------------------#

lines = Array.new
File.open('d6_input.txt').each { |line| lines << line.strip }

group_answers = [[]]

lines.each do |line|
  if line.empty?
    group_answers.push([])
  else
    group_answers.last.push(line)
  end
end

count_group_answers = group_answers.map { |answer| count_answer(answer) }

puts "Sum of counts: #{count_group_answers.inject(:+)}"

