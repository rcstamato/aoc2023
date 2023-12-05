def read_file(filename)
  input = []
  input_file = File.open(filename)
  input_lines = input_file.readlines.map(&:chomp)
  winning_hash = {}
  played_hash = {}

  input_lines.each do |line|
    line = line.gsub(/\s+/, " ")
    card_split = line.split(/: /)
    card_id = card_split[0].split(/\s+/)[1].to_i
    numbers_split = card_split[1].split(" | ")
    winning_split = numbers_split[0]
    played_split = numbers_split[1]

    winning_hash[card_id] = winning_split.split(/ /)
    played_hash[card_id] = played_split.split(/ /)
  end
  [winning_hash, played_hash]
end

def calculate_points_part1(winning, played)
  points = 0
  winning.each do |k,winning_numbers|
    matches = 0
    winning_numbers.each do |num|
      matches += 1 if played[k].include?(num)
    end
    points += 2**(matches-1) if matches > 0
  end

  points
end

def calculate_part2(winning, played)
  counter = {}
  winning.each do |k,_v|
    counter[k] = 1
  end

  winning.each do |k,winning_numbers|
    matches = 0
    winning_numbers.each do |num|
      matches += 1 if played[k].include?(num)
    end
    (k+1).upto(k+matches) do |i|
      counter[i] += counter[k] if counter[i] != nil
    end
  end

  counter.values.sum
end

hashes = read_file("day4_input.txt")
# puts calculate_points_part1(*hashes)
puts calculate_part2(*hashes)