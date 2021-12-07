def cal(line)
  init = get_initial(line)
  fuel = move(init)
  puts "#{fuel}"

  min = fuel.min
  return { position: fuel.index(min), fuel: min }
end

def move(init)
  # puts "#{init}"
  fuel = Array.new(init.size, 0)
  for p in (0..init.size-1)
    init.each_with_index do |val,i|
      fuel[p] += val * sum(p, i) if val > 0 
    end
  end
  return fuel
end

def sum(s, e)
  length = (s-e).abs
  return (1 + length) * length / 2
end

def get_initial(line)
  crabs = Array.new
  list = line.split(",").map(&:to_i)
  # puts "#{list}"

  list.each do |c|
    while crabs.size < c + 1
      crabs << 0
    end

    crabs[c] += 1
  end

  # puts "#{crabs}"
  return crabs
end

#---------Test---------#
input = ["16,1,2,0,4,2,7,1,2,14"]

result = cal(input.first)
puts "#{result[:fuel]} fuel must they spend to align to #{result[:position]} position"

#----------------------#

lines = Array.new
File.open('d7_input.txt').each { |line| lines << line.strip }

result = cal(lines.first)
puts "#{result[:fuel]} fuel must they spend to align to #{result[:position]} position"