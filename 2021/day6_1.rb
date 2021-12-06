def glow(init, day)
  if day > 0
    count_new = init.select{ |x| x == 0 }.size
    init = init.map{ |x| x > 0 ? x - 1 : 6 }
    for i in (1..count_new) 
      init.push 8 
    end

    # puts "#{day}: #{count_new} - #{init}"

    glow(init, day - 1)
  else
    return init.size
  end
end

def get_initial(line)
  line.split(",").map(&:to_i)
end

#---------Test---------#
input = ["3,4,3,1,2"]

init = get_initial(input.first)
day = 80
result = glow(init, day)
puts "#{result} lanternfish would there be after #{day} days"

#----------------------#

lines = Array.new
File.open('d6_input.txt').each { |line| lines << line.strip }

init = get_initial(lines.first)
day = 80
result = glow(init, day)
puts "#{result} lanternfish would there be after #{day} days"