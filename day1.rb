def number_from(a, b)
  "#{a}#{b}".to_i
end

def num_from_str(str)
  case str
  when 'one'
    1
  when 'two'
    2
  when 'three'
    3
  when 'four'
    4
  when 'five'
    5
  when 'six'
    6
  when 'seven'
    7
  when 'eight'
    8
  when 'nine'
    9
  else
    str.to_i
  end
end

input_file = File.open('day1_input.txt')
input = input_file.readlines.map(&:chomp)

# input = ['twone']

total = 0
input.each do |line|
  spelled_out_nums = %w[one two three four five six seven eight nine]
  regex_str = spelled_out_nums.reduce("[1-9]") { |concat, num| "#{concat}|#{num}" }
  regex_str_inv = spelled_out_nums.reduce("[1-9]") { |concat, num| "#{concat}|#{num.reverse}" }
  pattern = Regexp.new(regex_str)
  pattern_inv = Regexp.new(regex_str_inv)
  # pattern = Regexp.new("/[1-9]|one|two|three|four|five|six|seven|eight|nine/
  matches = line.scan(pattern)
  first_digit = matches.first
  matches_inv = line.reverse.scan(pattern_inv)
  last_digit = matches_inv.first
  num = number_from(num_from_str(first_digit), num_from_str(last_digit.reverse))
  puts "#{line},#{num}"

  total += num
end

puts "Total is #{total}"



