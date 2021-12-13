
def get_paper(dots)
  return dots.map{ |d| d.split(",").map(&:to_i) }
end

def fold(paper, instructions)
  ins = instructions.first
  line = ins.split(" ").last.split("=")
  value = line.last.to_i
  if line.first == "x"
    paper = fold_vertical(paper, value)      
  elsif line.first == "y"
    paper = fold_horizontal(paper, value)    
  end

  return paper
end

def fold_horizontal(paper, value)
  new_paper = Array.new
  paper.each do |p|
    if p.last > value
      new_y =  value * 2 - p.last
      new_paper << [p.first, new_y]
    else
      new_paper << p
    end
  end

  return new_paper.uniq
end

def fold_vertical(paper, value)
  new_paper = Array.new
  paper.each do |p|
    if p.first > value
      new_x =  value * 2 - p.first
      new_paper << [new_x, p.last]
    else
      new_paper << p
    end
  end

  return new_paper.uniq
end

def cal(inputs)
  paper = get_paper(inputs[0])
  new_paper = fold(paper, inputs[1])
  puts "#{new_paper}"

  return new_paper.size
end

#---------Test---------#
input = [["6,10","0,14","9,10", "0,3", "10,4", "4,11", "6,0", "6,12", 
  "4,1", "0,13", "10,12", "3,4", "3,0", "8,4", "1,10", "2,14", "8,10", "9,0"], 
  ["fold along y=7", "fold along x=5"]]

result = cal(input)
puts "#{result} dots are visible after completing just the first fold instruction on your transparent paper"
#----------------------#

lines = Array.new
File.open('d13_input.txt').each { |line| lines << line.strip }

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

result = cal(group_inputs)
puts "#{result} dots are visible after completing just the first fold instruction on your transparent paper"
