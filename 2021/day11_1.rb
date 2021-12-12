def get_dumbo(lines)
  dumbo = Array.new
  lines.each do |line|
    dumbo << line.split("").map(&:to_i)
  end

  # puts "#{dumbo}"
  return dumbo
end

def process(dumbo, times)
  sum = 0
  print(dumbo, "initial")
  for i in (1..times)
    dumbo = dumbo.map{ |row| row.map{ |o| o+1 } }
    # print(dumbo, "increase")
    flash(dumbo)
    # print(dumbo, "flash")
    sum += count_flash(dumbo)
  end
  # print(dumbo, "final")

  return sum
end

def flash(dumbo)
  # check = []
  # dumbo.each { |row| check << row.dup }
  dumbo.each_with_index do |row, i|
    row.each_with_index do |o, j|
      if o > 9
        # puts "#{o} for #{i},#{j}"
        adjacent(dumbo, i, j)
        # print(dumbo)
      end
    end
  end
end

def adjacent(dumbo, row, col)
  dumbo[row][col] = 0
  increamental(dumbo, row-1, col-1) if row > 0 && col > 0
  increamental(dumbo, row-1, col) if row > 0
  increamental(dumbo, row-1, col+1) if row > 0 && col < dumbo.first.size - 1
  increamental(dumbo, row, col-1) if col > 0
  increamental(dumbo, row, col+1) if col < dumbo.first.size - 1
  increamental(dumbo, row+1, col-1) if row < dumbo.size - 1 && col > 0
  increamental(dumbo, row+1, col) if row < dumbo.size - 1 
  increamental(dumbo, row+1, col+1) if row < dumbo.size - 1 && col < dumbo.first.size - 1
end

def increamental(dumbo, row, col)
  if dumbo[row][col] > 0
    dumbo[row][col] += 1
    adjacent(dumbo, row, col) if dumbo[row][col] > 9
  end
end

def count_flash(dumbo)
  sum = 0
  dumbo.each do |row|
    sum += row.select{ |o| o==0 }.size
  end

  return sum
end

def cal(lines, times)
  dumbo = get_dumbo(lines)
  result = process(dumbo, times)
  
  return result
end

def print(dumbo, title)
  puts "-#{title}---------------------------"
  dumbo.each do |row|
    puts "#{row}"
  end
end

#---------Test---------#
input = ["5483143223", 
  "2745854711", 
  "5264556173", 
  "6141336146", 
  "6357385478", 
  "4167524645", 
  "2176841721", 
  "6882881134", 
  "4846848554", 
  "5283751526"]

times = 100
result = cal(input, times)
puts "Total flashes are there after #{times} steps: #{result}"

#----------------------#

lines = Array.new
File.open('d11_input.txt').each { |line| lines << line.strip }

times = 100
result = cal(lines, times)
puts "Total flashes are there after #{times} steps: #{result}"
