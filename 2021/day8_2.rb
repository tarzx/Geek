def get_signal_output(lines)
  list = Array.new
  lines.each do |line|
    group = line.split(" | ")
    signal = group[0].split(" ")
    output = group[1].split(" ")
    list << { signal: signal, output: output }
  end

  return list
end

def decrypt_output(list)
  segments = Array.new
  list.each do |item|
    pattern = get_pattern(item[:signal] | item[:output])
    segments << item[:output].map{ |s| read_segment(s, pattern) }
  end
  
  output = segments.map{ |segment| cal_output(segment) }
  return output
end

def get_pattern(signal)
  # puts "#{signal}"
  pattern = Array.new(7, [])
  pos = Array.new(10,[])
  pos[8] = ["a", "b", "c", "d", "e", "f", "g"]

  segment_one = signal.select{ |s| s.length == 2 }
  if segment_one.any?
    # puts "1: #{segment_one}"
    pos[1] = segment_one.first.split("")
  end

  segment_seven = signal.select{ |s| s.length == 3 }
  if segment_seven.any?
    # puts "7: #{segment_seven}"
    pos[7] = segment_seven.first.split("")
    pattern[0] = pos[7] - pos[1] if pos[1].any?
  end

  segment_four = signal.select{ |s| s.length == 4 }
  if segment_four.any?
    # puts "4: #{segment_four}"
    pos[4] = segment_four.first.split("")
  end

  segment_eight = signal.select{ |s| s.length == 7 }
  if segment_eight.any?
    # puts "8: #{segment_eight}"
    pos[8] = segment_eight.first.split("")
  end

  segment_nzs = signal.select{ |s| s.length == 6 }
  if segment_nzs.any?
    segment_nine = segment_nzs.select{ |s| (s.split("")&pos[4]).size == 4 }
    if segment_nine.any?
      # puts "9: #{segment_nine}"
      pos[9] = segment_nine.first.split("")
      pattern[4] = pos[8] - pos[9]
      pattern[6] = pos[9] - pos[4] - pos[7] if pos[4].any? && pos[7].any?
    end

    segment_zero = segment_nzs.select{ |s| (s.split("")&pos[4]).size != 4 && (s.split("")&pos[1]).size == 2 }
    if segment_zero.any?
      # puts "0: #{segment_zero}"
      pos[0] = segment_zero.first.split("")
      pattern[3] = pos[8] - pos[0]
    end

    segment_six = segment_nzs.select{ |s| (s.split("")&pos[4]).size != 4 && (s.split("")&pos[1]).size != 2 }
    if segment_six.any?
      # puts "6: #{segment_six}"
      pos[6] = segment_six.first.split("")
      pattern[2] = pos[8] - pos[6]
      pattern[5] = pos[1] & pos[6] if pos[1].any?
    end
  end

  segment_ttf = signal.select{ |s| s.length == 5 }
  if segment_ttf.any?
    segment_three = segment_ttf.select{ |s| (s.split("")&pos[1]).size == 2 }
    if segment_three.any?
      # puts "3: #{segment_three}"
      pos[3] = segment_three.first.split("")
      pattern[1] = pos[9] - pos[3] if pos[9].any?
      pattern[3] = pos[3] - pos[0] if pos[0].any?
      pattern[2] = pos[3] - pos[6] if pos[6].any?
    end

    segment_two = segment_ttf.select{ |s| (s.split("")&pos[4]).size == 2 }
    if segment_two.any?
      # puts "2: #{segment_two}"
      pos[2] = segment_two.first.split("")
      pattern[3] = pos[2] - pos[0] if pos[0].any?
      pattern[5] = pos[3] - pos[2] if pos[3].any?
    end

    segment_five = segment_ttf.select{ |s| (s.split("")&pos[4]).size == 3 && (s.split("")&pos[1]).size == 1 }
    if segment_five.any?
      # puts "5: #{segment_five}"
      pos[5] = segment_five.first.split("")
      pattern[4] = pos[6] - pos[5] if pos[6].any?
      pattern[2] = pos[9] - pos[5] if pos[9].any?
      pattern[5] = pos[1] & pos[5] if pos[1].any?
    end
  end

  # puts "#{pos}"
  return pattern.flatten
end

def read_segment(segment, pattern)
  # puts "#{segment} - #{pattern}"
  if segment.length == 2
    return 1
  elsif segment.length == 3
    return 7
  elsif segment.length == 4
    return 4
  elsif segment.length == 5
    if segment.split("").include?(pattern[2]) && segment.split("").include?(pattern[4])
      return 2
    elsif segment.split("").include?(pattern[2]) && segment.split("").include?(pattern[5])
      return 3
    elsif segment.split("").include?(pattern[1]) && segment.split("").include?(pattern[5])
      return 5
    end  
  elsif segment.length == 6
    if !segment.split("").include?(pattern[3])
      return 0
    elsif !segment.split("").include?(pattern[2])
      return 6
    elsif !segment.split("").include?(pattern[4])
      return 9
    end 
  elsif segment.length == 7
    return 8
  end
end

def cal_output(segment)
  sum = 0
  size =  segment.size - 1
  segment.each_with_index do |s, i|
    sum += s * (10**(size-i))
  end

  return sum
end

def cal(lines)
  list = get_signal_output(lines)
  output = decrypt_output(list)
  
  puts "#{output}"
  return output.inject(:+)
end

#---------Test---------#
input = ["be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe",
"edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc",
"fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg",
"fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb",
"aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea",
"fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb",
"dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe",
"bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef",
"egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb",
"gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce"]

result = cal(input)
puts "#{result} times do digits 1, 4, 7, or 8 appear"

#----------------------#

lines = Array.new
File.open('d8_input.txt').each { |line| lines << line.strip }

result = cal(lines)
puts "#{result} times do digits 1, 4, 7, or 8 appear"
