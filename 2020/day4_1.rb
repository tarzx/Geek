lines = Array.new
File.open('d4_input.txt').each { |line| lines << line.strip }

passports = [{}]

lines.each do |line|
  if line.empty?
    passports.push({})
  else
    fields = line.split(' ')
    fields.each do |field|
      data = field.split(':')
      passports.last.store(data[0], data[1])
    end
  end
end

valid = 0
invalid = 0
passports.each do |passport|
  if passport.key?('byr') && passport.key?('iyr') && passport.key?('eyr') && 
    passport.key?('hgt') && passport.key?('hcl') && passport.key?('ecl') && passport.key?('pid')
    valid += 1
  else
    invalid += 1
  end
end

puts "Valid: #{valid}, Invalid: #{invalid}"