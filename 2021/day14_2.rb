def cal(inputs, times)
  pattern = get_pattern(inputs[0])
  pair_pattern = get_pair_pattern(pattern)
  rules = get_rules(inputs[1])

  reform = run_rules(pair_pattern, rules, times)
  count_letter = count_letter(reform)
  count = cal_letter(count_letter, pattern)
  puts "#{count}"

  sort_list = get_min_max(count)
  puts "#{sort_list.last[:count]}, #{sort_list.first[:count]}"

  return sort_list.last[:count] - sort_list.first[:count]
end

def get_pattern(input)
  input.first
end

def get_pair_pattern(pattern)
  pairs = Array.new
  index = 0
  while index < pattern.size - 1
    pairs << pattern.slice(index..index+1)
    index += 1
  end

  return pairs
end

def get_rules(input)
  input.map{ |r| r.split(" -> ") }
end

def run_rules(patterns, rules, times)
  pairs = patterns.group_by(&:to_s).map { |a| { pair: a[0], count: a[1].size } }
  for i in (1..times)
    count = 0
    reform = Array.new

    # puts "#{pairs}"
    pairs.each do |pair|
      list = find_rule(rules, pair[:pair])
      list.each do |rule|
        check = reform.select{ |c| c[:pair] == rule }.first
        if check
          check[:count] += pair[:count]
        else
          reform << { pair: rule, count: pair[:count] }
        end
        count += pair[:count]
      end
    end
    pairs = reform
    # puts "#{count}"
  end
  return pairs
end

def find_rule(rules, pair)
  rule = rules.select{ |r| r.first == pair }.first
  mid = rule ? rule.last : ""

  pairs = Array.new
  pair.split("").each_with_index do |part, i|
    pairs << part.insert((i-1).abs, mid)
  end
  return pairs
end

def count_letter(pairs)
  count = Array.new
  pairs.each do |pair|
    pair[:pair].split("").each do |p|
      check = count.select{ |c| c[:letter] == p }.first
      if check
        check[:count] += pair[:count]
      else
        count << { letter: p, count: pair[:count] }
      end
    end
  end

  return count
end

def cal_letter(count_letter, pattern)
  except = [pattern.split("").first, pattern.split("").last]
  puts "#{except}"
  count_letter.map do |c|
    if except.include? c[:letter]
      cc = except.select { |e| e == c[:letter] }.size
      { letter: c[:letter], count: (c[:count]+cc)/2 }
    else
      { letter: c[:letter], count: c[:count]/2 }
    end
  end
end

def get_min_max(count_list)
  count_list.sort_by{ |x| x[:count] }
end

#---------Test---------#
input = [["NNCB"],
["CH -> B", "HH -> N", "CB -> H", "NH -> C", "HB -> C", "HC -> B", "HN -> C", "NN -> C", 
  "BH -> H", "NC -> B", "NB -> B", "BN -> B", "BB -> N", "BC -> B", "CC -> N", "CN -> C"]]

times = 40
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

times = 40
result = cal(group_inputs, times)
puts "#{result} - you get if you take the quantity of the most common element and subtract the quantity of the least common element"
