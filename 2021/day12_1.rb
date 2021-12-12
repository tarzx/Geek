def get_map(lines)
  map = Array.new
  lines.each do |line|
    map << line.split("-")
  end

  # puts "#{map}"
  return map
end

def find_path(map)
  puts "#{map}"
  start_node = "start"
  set = Array.new
  set = get_path(map, start_node, [start_node], set)
  return set.size
end

def get_path(map, start_node, previous_nodes, set)
  map.select{ |p| p.include? start_node }.each do |line|
    nodes = previous_nodes.clone
    next_node = get_node(line, start_node)
    if !previous_nodes.include?(next_node) || next_node == next_node.upcase
      nodes << next_node
      if next_node == "end"
        set << nodes
        # puts "#{nodes}"
        next
      end

      get_path(map, next_node, nodes, set)
    end
  end

  return set
end

def get_node(path, node)
  # puts "#{path}:#{node}"
  path.select{ |n| n != node }.first
end

def cal(lines)
  map = get_map(lines)
  result = find_path(map)

  return result
end

#---------Test---------#
input1 = ["start-A", "start-b", "A-c", "A-b", "b-d", "A-end", "b-end"]

result = cal(input1)
puts "#{result} Paths through this cave system are there that visit small caves at most once."

input2 = ["dc-end", "HN-start", "start-kj", "dc-start", "dc-HN", "LN-dc", "HN-end", "kj-sa", "kj-HN", "kj-dc"]

result = cal(input2)
puts "#{result} Paths through this cave system are there that visit small caves at most once."

input3 = ["fs-end", "he-DX", "fs-he", "start-DX", "pj-DX", "end-zg", "zg-sl", "zg-pj", 
  "pj-he", "RW-he", "fs-DX", "pj-RW", "zg-RW", "start-pj", "he-WI", "zg-he", "pj-fs", "start-RW"]

result = cal(input3)
puts "#{result} Paths through this cave system are there that visit small caves at most once."
#----------------------#

lines = Array.new
File.open('d12_input.txt').each { |line| lines << line.strip }

result = cal(lines)
puts "#{result} Paths through this cave system are there that visit small caves at most once."
