lines = Array.new
File.open('d1_input.txt').each { |line| lines << line.to_i }

# lines.each_with_index do |x, i|
#   lines.each_with_index do |y, j|
#     if i != j
#       lines.each_with_index do |z, k|
#         if i != k
#           if x + y + z == 2020
#             puts "#{x} * #{y} * #{z} = #{x*y*z}"
#           end
#         end
#       end
#     end
#   end
# end


hash = lines.map { |inp|
  { x: inp, r: 2020 - inp }
}

hash.each do |h|
  tg = h[:r]
  s = tg/2
  p1 = Array.new(s+1)
  p2 = Array.new(s+1)

  lines.each do |inp|
    if inp != h[:x]
      if inp>=0 && inp <= s
        p1[s - inp%s] = inp
      elsif inp > s && inp < tg
        p2[inp%s] = inp
      elsif inp == tg
        p2[s] = inp
      end
    end
  end

  p1.each_with_index do |p, i|
    if p && p2[i]
      puts "#{h[:x]} * #{p} * #{p2[i]} = #{h[:x]*p*p2[i]}"
    end
  end
end
