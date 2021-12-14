def cal(inputs, times)
  pattern = get_pattern(inputs[0])
  rules = get_rules(inputs[1])

  # puts "#{pattern} - #{rules}"
  for i in (1..times)
    pattern = insert(pattern, rules)
    # puts "#{pattern}"
  end

  count_list = cal_letter(pattern)
  sort_list = get_min_max(count_list)
  puts "#{sort_list.last[:count]}, #{sort_list.first[:count]}"

  return sort_list.last[:count] - sort_list.first[:count]
end

def get_pattern(input)
  input.first
end

def get_rules(input)
  input.map{ |r| r.split(" -> ") }
end

def insert(pattern, rules)
  reform = ""
  index = 0
  while index < pattern.size - 1
    reform = reform.chop
    pair = pattern.slice(index..index+1)
    reform += find_rule(rules, pair)
    index += 1
  end

  return reform
end

def find_rule(rules, pair)
  rule = rules.select{ |r| r.first == pair }.first
  mid = rule ? rule.last : ""
  return pair.clone.insert(1, mid)
end

def cal_letter(pattern)
  count_list = Array.new
  pattern.split("").each do |p|
    check = count_list.select{ |c| c[:letter] == p }.first
    if check
      check[:count] += 1
    else
      count_list << { letter: p, count: 1 }
    end
  end

  return count_list
end

def get_min_max(count_list)
  count_list.sort_by{ |x| x[:count] }
end

#---------Test---------#
input = [["NNCB"],
["CH -> B", "HH -> N", "CB -> H", "NH -> C", "HB -> C", "HC -> B", "HN -> C", "NN -> C", 
  "BH -> H", "NC -> B", "NB -> B", "BN -> B", "BB -> N", "BC -> B", "CC -> N", "CN -> C"]]

times = 10
result = cal(input, times)
puts "#{result} - you get if you take the quantity of the most common element and subtract the quantity of the least common element"
#----------------------#

lines = Array.new
File.open('d14_input.txt').each { |line| lines << line.strip }

group_inputs = Array.new(1, [])

lines.each do |line|
  if line.empty?
    group_inputs.push([])
  else
    answer = group_inputs.pop
    answer.push line
    group_inputs.push(answer)
  end
end

times = 10
result = cal(group_inputs, times)
puts "#{result} - you get if you take the quantity of the most common element and subtract the quantity of the least common element"
