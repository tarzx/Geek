def get_list(lines)
  list = Array.new
  lines.each do |line|
    list << line.split("")
  end

  # puts "#{list}"
  return list
end

def select_corrupted(list)
  corrupted = Array.new
  list.each do |line|
    container = check_container(line)
    corrupted << container if container
  end

  # puts "#{corrupted.map{ |x| x[:expect] }}"
  return corrupted
end

def check_container(line)
  stack = Array.new
  # puts "#{line}"
  line.each do |p|
    # puts "#{p} - #{stack}"
    if ["[", "(", "{", "<"].include?(p)
      stack << p
    elsif p == "]"
      return { line: line, expect: "]" } if stack.pop != "["
    elsif p == ")"
      return { line: line, expect: ")" } if stack.pop != "("
    elsif p == "}"
      return { line: line, expect: "}" } if stack.pop != "{"
    elsif p == ">"
      return { line: line, expect: ">" } if stack.pop != "<"
    else
      return nil
    end
  end

  return nil
end

def cal_score(corrupted)
  sum = 0
  corrupted.map{ |x| x[:expect] }.each do |c|
    if c == ")"
      sum += 3
    elsif c == "]"
      sum += 57
    elsif c == "}"
      sum += 1197
    elsif c == ">"
      sum += 25137
    end
  end

  return sum
end

def cal(lines)
  list = get_list(lines)
  corrupted = select_corrupted(list)
  result = cal_score(corrupted)

  return result
end

#---------Test---------#
input = ["[({(<(())[]>[[{[]{<()<>>", 
"[(()[<>])]({[<{<<[]>>(",
"{([(<{}[<>[]}>{[]{[(<()>",
"(((({<>}<{<{<>}{[]{[]{}",
"[[<[([]))<([[{}[[()]]]",
"[{[{({}]{}}([{[{{{}}([]",
"{<[[]]>}<{[{[{[]{()[[[]",
"[<(<(<(<{}))><([]([]()",
"<{([([[(<>()){}]>(<<{{",
"<{([{{}}[<[[[<>{}]]]>[]]"]

result = cal(input)
puts "The sum of the risk levels of all low points on your heightmap: #{result}"

#----------------------#

lines = Array.new
File.open('d10_input.txt').each { |line| lines << line.strip }

result = cal(lines)
puts "The sum of the risk levels of all low points on your heightmap: #{result}"
