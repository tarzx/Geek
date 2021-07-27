def get_rule_hashes(rules)
  hashes = []
  rules.each do |rule|
    if rule.include?("contain")
      bag = {}
      contain = rule.split(" contain ")
      color = get_color_bag(contain.first)
      if rule.include?("no other bags")
        bag.store(color, nil)
      else
        bag.store(color, get_contain_bags(contain.last))
      end
      hashes.push(bag)
    end
  end

  return hashes
end

def get_contain_bags(contain)
  contain_bags = []
  bags = contain.split(', ')
  bags.each do |bag|
    data = {}
    rule = bag.split(' ')
    number = rule.shift .to_i
    color = get_color_bag(rule.join(' '))
    data.store(color, number)
    contain_bags.push(data)
  end
  return contain_bags
end

def get_color_bag(bag)
  return bag.split(" bag").first
end

def deep_find(obj, key)
  if obj.respond_to?(:key?) && obj.key?(key)
    obj
  elsif obj.respond_to?(:each)
    r = nil
    obj.find{ |*a| r = deep_find(a.last,key) }
    obj if r
  end
end

def find_exist(rules, key)
  bags = []
  check_bags = [key]
  hashes = get_rule_hashes(rules)

  while check_bags.any?
    bag = check_bags.shift
    bags.push(bag) if bag != key

    found = []
    hashes.each do |hash|
      exist = deep_find(hash, bag)
      found.push(*exist.keys) if exist
    end

    check = found.select { |f| f != bag && !bags.include?(f) }
    check_bags |= check.uniq
  end

  return bags
end

#---------Test---------#
rules = ["light red bags contain 1 bright white bag, 2 muted yellow bags.",
"dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
"bright white bags contain 1 shiny gold bag.",
"muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
"shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
"dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
"vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
"faded blue bags contain no other bags.",
"dotted black bags contain no other bags."]

# puts find_exist(rules, "shiny gold")
#----------------------#

lines = Array.new
File.open('d7_input.txt').each { |line| lines << line.strip }

all_bags = find_exist(lines, "shiny gold")
puts "#{all_bags.count} bags color."
