def cal(line, day)
  init = get_initial(line)
  list = glow(init, day)
  return list.inject(:+)
end

def glow(init, day)
  if day <= 0
    return init
  else
    max_day = day >= 7 ? 7 : day
    length = init.size > 9 ? init.size : 9
    list = Array.new(length, 0)
    init.each_with_index do |val, i|
      if val > 0
        if i < max_day
          list[7 - max_day + i] += val
          list[7 - max_day + i + 2] += val
        else
          list[i - max_day] += val
        end
      end
      # puts "#{list}"
    end
    
    puts "#{day} - #{list}"
    return day >= 7 ? glow(list, day - 7) : list
  end
end

def get_initial(line)
  lanternfish = Array.new
  list = line.split(",").map(&:to_i)
  puts "#{list}"

  list.each do |fish|
    while lanternfish.size < fish + 1
      lanternfish << 0
    end

    lanternfish[fish] += 1
  end

  # puts "#{lanternfish}"
  return lanternfish
end

#---------Test---------#
input = ["3,4,3,1,2"]

day = 256
result = cal(input.first, day)
puts "#{result} lanternfish would there be after #{day} days"

#----------------------#

lines = Array.new
File.open('d6_input.txt').each { |line| lines << line.strip }

day = 256
result = cal(lines.first, day)
puts "#{result} lanternfish would there be after #{day} days"