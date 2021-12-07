def get_number_list(line)
  line.strip.split(",").map(&:to_i)
end

def get_board(line)
  # board = Array.new
  # rows = line.split("\n")
  # rows.each do |row|
  #   next if row.empty?
  #   board << row.split(" ").map(&:to_i)
  # end

  # return board
  line.strip.split(" ").map(&:to_i)
end

def bingo(lines)
  # Initial game
  number_list = get_number_list(lines.first)
  puts "#{number_list}"

  board_list = Array.new
  lines.drop(1).each do |line|
    board = get_board(line)
    board_list << board
  end

  # Start game
  score = 0
  number_list.each do |number|
    # puts "Number: #{number}"
    mark_number(board_list, number)

    bingo = get_bingo_boards(board_list)
    if bingo
      # puts "#{number} - #{bingo}"
      score = get_score(bingo, number)
      break
    end
  end

  return score
end

def mark_number(board_list, number)
  board_list.map! do |board|
    if board.include?(number)
      board.map! { |x| x == number ? -1 : x}
    else
      board
    end
  end
end

def get_bingo_boards(board_list)
  board_list.each do |board|
    return board if check_bingo(board)
  end

  return nil
end

def check_bingo(board)
  size = Math.sqrt(board.size).to_i
  # Check row
  for i in (0..size-1)
    sum = 0
    for j in (0..size-1)
      sum += board[(i * size) + j]
    end

    return true if sum == -size
  end

  # Check col
  for i in (0..size-1)
    sum = 0
    for j in (0..size-1)
      sum += board[i + (j * size)]
    end

    return true if sum == -size
  end

  return false
end

def get_score(board, last_number)
  sum = board.select { |x| x >= 0 }.inject(:+)
  return sum * last_number
end

#---------Test---------#
input = ["\n7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1",\
"\n22 13 17 11 0\n8 2 23 4 24\n21 9 14 16 7\n6 10 3 18 5\n1 12 20 15 19",\
"\n3 15 0 2 22\n9 18 13 17 5\n19 8 7 25 23\n20 11 10 24 4\n14 21 16 12 6",\
"\n14 21 17 24 4\n10 16 15 9 19\n18 8 23 26 20\n22 11 13 6 5\n2 0 12 3 7"]

score = bingo(input)
puts "Score: #{score}"

#----------------------#

lines = Array.new
File.open('d4_input.txt').each { |line| lines << line.strip }

group_answers = [""]

lines.each do |line|
  if line.empty?
    group_answers.push("")
  else
    answer = group_answers.pop
    group_answers.push(answer + "\n" + line)
  end
end

score = bingo(group_answers)
puts "Score: #{score}"