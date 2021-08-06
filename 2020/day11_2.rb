def setup(seats)
  change = 1 # initial not 0
  # print(seats)

  while change > 0
    result = reseat(seats)
    change = count_change(seats, result)
    # puts "Change: #{change}"
    # print(result)
    seats = result
  end

  return seats
end

def reseat(seats)
  occupied_seats = []
  seats.each_with_index do |row, i|
    new_row = ""
    row.chars.each_with_index do |seat, j|
      if seat == "."
        new_row.concat(seat)
      else
        count = count_occupied_adjacent(seats, i, j)
        if count == 0
          new_row.concat("#")
        elsif count >= 5
          new_row.concat("L")
        else
          new_row.concat(seat)
        end
      end
    end
    occupied_seats.push(new_row)
  end

  return occupied_seats
end

def count_occupied_adjacent(seats, i, j)
  count = 0

  adjacents = { n: nil, s: nil, w: nil, e: nil, nw: nil, ne: nil, sw: nil, se: nil }

  r = 1
  while adjacents.find{ |k,v| !is_blocked(v) }
    # Adjacent seats
    adjacents[:n] = i < r ? "|" : seats[i-r][j] if !is_blocked(adjacents[:n])
    adjacents[:s] = i >= seats.length - r ? "|" : seats[i+r][j] if !is_blocked(adjacents[:s])
    adjacents[:w] = j < r ? "|" : seats[i][j-r] if !is_blocked(adjacents[:w])
    adjacents[:e] = j >= seats[i].length - r ? "|" : seats[i][j+r] if !is_blocked(adjacents[:e])
    adjacents[:nw] = i < r || j < r ? "|" : seats[i-r][j-r] if !is_blocked(adjacents[:nw])
    adjacents[:ne] = i < r || j+r >= seats[i].length ? "|" : seats[i-r][j+r] if !is_blocked(adjacents[:ne])
    adjacents[:sw] = i+r >= seats.length || j < r ? "|" : seats[i+r][j-r] if !is_blocked(adjacents[:sw])
    adjacents[:se] = i+r >= seats.length || j+r >= seats[i].length ? "|" : seats[i+r][j+r] if !is_blocked(adjacents[:se])

    r += 1
  end

  adjacents.each do |k, v|
    count += 1 if v == "#"
  end

  return count
end

def is_blocked(seat)
  return ["|", "#", "L"].include?(seat)
end

def count_change(original, seats)
  change = 0
  if original.length == seats.length
    original.each_with_index do |row, i|
      if row.length == seats[i].length
        for j in 0..row.length-1 do
          change += 1 if row[j] != seats[i][j]
        end
      end
    end
  end

  return change
end

def count_occupied(seats)
  count = 0
  seats.each do |row|
    row.chars.each do |seat|
      count += 1 if seat == "#"
    end
  end

  return count
end

def print(seats)
  seats.each do |row|
    puts row
  end
  puts "----------------"
end

#---------Test---------#
input = [
  "L.LL.LL.LL", 
  "LLLLLLL.LL", 
  "L.L.L..L..", 
  "LLLL.LL.LL", 
  "L.LL.LL.LL", 
  "L.LLLLL.LL", 
  "..L.L.....", 
  "LLLLLLLLLL", 
  "L.LLLLLL.L", 
  "L.LLLLL.LL"
]

# seats = setup(input)
# puts "Occupied seat: #{count_occupied(seats)}"

#----------------------#

lines = Array.new
File.open('d11_input.txt').each { |line| lines << line.strip }

seats = setup(lines)
puts "Occupied seat: #{count_occupied(seats)}"
