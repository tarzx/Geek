def count_answer(answer)
  return answer.chars.uniq.count
end

#---------Test---------#
puts count_answer('abc') #3.
puts count_answer('abac') #3.
puts count_answer('aaaa') #1.
puts count_answer('b') #1.
#----------------------#

lines = Array.new
File.open('d6_input.txt').each { |line| lines << line.strip }

group_answers = [""]

lines.each do |line|
  if line.empty?
    group_answers.push("")
  else
    answer = group_answers.pop
    group_answers.push(answer + line)
  end
end

count_group_answers = group_answers.map { |answer| count_answer(answer) }

puts "Sum of counts: #{count_group_answers.inject(:+)}"