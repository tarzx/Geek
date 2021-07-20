lines = Array.new
File.open('d1_input.txt').each { |line| lines << line.to_i }

p1 = Array.new(1010)
p2 = Array.new(1010)

lines.each do |inp|
  if inp >= 0 && inp < 1010 
    p1[1010 - inp - 1] = inp
  elsif inp > 1010 && inp <= 2020
    p2[inp%1010 - 1] = inp
  end
end

p1.each_with_index do |p, i|
  if p && p2[i]
    puts "#{p} * #{p2[i]} = #{p*p2[i]}"
  end
end

