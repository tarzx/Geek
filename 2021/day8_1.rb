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

def check_segment(list)
  segments = Array.new
  list.each do |item|
    segment = Hash.new
    segment[:signal] = item[:signal].map { |s| s.length }
    segment[:output] = item[:output].map { |s| s.length } 
    segments << segment
  end

  return segments
end

def count_output(list)
  segment_one = 2
  segment_four = 3
  segment_seven = 4
  segment_eight = 7
  digit = [segment_one, segment_four, segment_seven, segment_eight]

  count_output = Array.new
  list.each do |item|
    count = item[:output].select{ |s| digit.include?(s) }
    count_output.push(*count)
  end

  return count_output
end 

def cal(lines)
  list = get_signal_output(lines)
  segment = check_segment(list)
  count = count_output(segment)
  return count.size
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
