def check_valid_passport(passport)
  begin
    # puts passport

    raise 'byr' if !passport.key?('byr') || passport['byr'].to_i < 1920 || passport['byr'].to_i > 2002  
    raise 'iyr' if !passport.key?('iyr') || passport['iyr'].to_i < 2010 || passport['iyr'].to_i > 2020
    raise 'eyr' if !passport.key?('eyr') || passport['eyr'].to_i < 2020 || passport['eyr'].to_i > 2030
    raise 'hgt' if !passport.key?('hgt') || !/[0-9]+(cm|in)/.match(passport['hgt']) 
    height = passport['hgt'][0..-3].to_i
    raise 'hgt' if passport['hgt'].end_with?("cm") && (height.to_i < 150 || height.to_i > 193)
    raise 'hgt' if passport['hgt'].end_with?("in") && (height.to_i < 59 || height.to_i > 76)
    raise 'hcl' if !passport.key?('hcl') || !/#[0-9a-f]{6}/.match(passport['hcl']) 
    raise 'ecl' if !passport.key?('ecl') || !['amb','blu','brn','gry','grn','hzl','oth'].include?(passport['ecl'])
    raise 'pid' if !passport.key?('pid') || !/[0-9]{9}/.match(passport['pid']) 
    
    return true
  rescue Exception => e
    puts "#{e.message} - #{passport[e.message]}"
    return false
  end
end

def get_key_value(line)
  key = {}
  fields = line.split(' ')
  fields.each do |field|
    data = field.split(':')
    key.store(data[0], data[1])
  end

  return key
end

#---------Test---------#
line = "hcl:dab227 iyr:2012 ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277"
passport = {}.merge!(get_key_value(line))
puts check_valid_passport passport

#----------------------#


lines = Array.new
File.open('d4_input.txt').each { |line| lines << line.strip }

passports = [{}]

lines.each do |line|
  passport = passports.last
  if line.empty?
    passports.push({})
  else
    passport.merge!(get_key_value(line))
  end
end

valid = 0
invalid = 0
passports.each do |passport|
  is_valid = check_valid_passport(passport)
  if is_valid
    valid += 1
  else
    invalid += 1
  end
end

puts "All: #{passports.length}, Valid: #{valid}, Invalid: #{invalid}"


