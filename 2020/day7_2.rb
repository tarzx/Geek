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

def find_contain(hashes, key)
  number_of_bags = 0

  found = hashes.select {|obj| obj.key?(key) }
  found.each do |item|
    if item[key]
      item[key].each do |bag|
        bag.keys.each do |color|
          number_color_bag = bag[color] * find_contain(hashes, color)
          number_of_bags += number_color_bag
        end

      end
    end

    number_of_bags += 1
  end

  return number_of_bags
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

# hashes = get_rule_hashes(rules)
# all_bags = find_contain(hashes, "shiny gold") - 1 #minus itself
# puts "#{all_bags} bags color." 
#----------------------#

lines = Array.new
File.open('d7_input.txt').each { |line| lines << line.strip }

hashes = get_rule_hashes(lines)
all_bags = find_contain(hashes, "shiny gold") - 1 #minus itself
puts "#{all_bags} bags color."
