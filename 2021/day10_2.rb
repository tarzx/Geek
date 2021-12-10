def get_list(lines)
  list = Array.new
  lines.each do |line|
    list << line.split("")
  end

  # puts "#{list}"
  return list
end

def select_incomplete(list)
  incomplete = Array.new
  list.each do |line|
    container = check_container(line)
    incomplete << container if container
  end

  # puts "#{incomplete}"
  return incomplete
end

def check_container(line)
  stack = Array.new
  # puts "#{line}"
  line.each do |p|
    # puts "#{p} - #{stack}"
    if ["[", "(", "{", "<"].include?(p)
      stack << p
    elsif p == "]"
      return nil if stack.pop != "["
    elsif p == ")"
      return nil if stack.pop != "("
    elsif p == "}"
      return nil if stack.pop != "{"
    elsif p == ">"
      return nil if stack.pop != "<"
    else
      return nil
    end
  end

  # puts "#{stack}"
  remain = Array.new
  while stack.any?
    s = stack.pop
    if s == "["
      remain << "]"
    elsif s == "("
      remain << ")"
    elsif s == "{"
      remain << "}"
    elsif s == "<"
      remain << ">"
    end
  end

  return { line: line, remain: remain } if remain.any?
end

def cal_scores(incomplete)
  scores = Array.new
  incomplete.map{ |x| x[:remain] }.each do |remain|
    sum = 0
    remain.each do |s|
      if s == ")"
        sum = (sum * 5) + 1
      elsif s == "]"
        sum = (sum * 5) + 2
      elsif s == "}"
        sum = (sum * 5) + 3
      elsif s == ">"
        sum = (sum * 5) + 4
      end
    end
    # puts "#{remain} - #{sum}"
    scores << sum
  end

  return scores
end

def get_middle(scores)
  size = scores.size
  return scores.sort[size/2]
end

def cal(lines)
  list = get_list(lines)
  incomplete = select_incomplete(list)
  scores = cal_scores(incomplete)

  return get_middle(scores)
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
puts "The middle score: #{result}"

#----------------------#

lines = Array.new
File.open('d10_input.txt').each { |line| lines << line.strip }

result = cal(lines)
puts "The middle score: #{result}"
