def read_input(code)
  if /^(F|B)+$/.match(code) 
    code.gsub!('F', '0')
    code.gsub!('B', '1')
  elsif /^(L|R)+$/.match(code) 
    code.gsub!('L', '0')
    code.gsub!('R', '1')
  end

  return code.to_i(2)
end

def read_boarding_pass(code)
  if code.length == 10
    row = read_input(code[0..-4])
    col = read_input(code.chars.last(3).join)
    return row * 8 + col
  end

  return 0
end

# #---------Test---------#
# puts read_boarding_pass('FBFBBFFRLR') #row 44, column 5, seat ID 357.
# puts read_boarding_pass('BFFFBBFRRR') #row 70, column 7, seat ID 567.
# puts read_boarding_pass('FFFBBBFRRR') #row 14, column 7, seat ID 119.
# puts read_boarding_pass('BBFFBBFRLL') #row 102, column 4, seat ID 820.
# #----------------------#


lines = Array.new
File.open('d5_input.txt').each { |line| lines << line.strip }

seat_ids = lines.map { |line| read_boarding_pass(line) }

my_seat = 0
sorted_seat = seat_ids.sort
sorted_seat.each_with_index do |seat,i|
  if seat - sorted_seat.first != i
    my_seat = seat - 1
    break
  end
end

puts "My seat id: #{my_seat}"
