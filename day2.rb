#
# input_file = File.open('day1_input.txt')
# input = input_file.readlines.map(&:chomp)

# input = ['twone']

def read_file(filename)
  input = []
  input_file = File.open(filename)
  input_lines = input_file.readlines.map(&:chomp)

  input_lines.each do |line|
    hh = {}
    game_split = line.split(/: /)
    hh["game"] = game_split[0].split(/ /)[1].to_i
    res_split = game_split[1].split(/; /)
    res_split.each do |single_res|
      single_res.split(/, /).each do |c|
        cube_split = c.split(/ /)
        hh[cube_split[1]] = [hh[cube_split[1]]||0, cube_split[0].to_i].max
      end
    end
    input << hh
  end
  input
end

def constraints_ok?(game, constraints)
  colors = %w[red green blue]
  colors.each do |color|
    game[color] = 0 if game[color].nil?
    return false if game[color] > constraints[color]
  end

  true
end


def part1
  constraints = {
    "red" => 12,
    "green" => 13,
    "blue" => 14
  }
  input = read_file('day2_input.txt')

  puts input
  sum = 0
  input.each do |game|
    sum += game["game"] if constraints_ok?(game, constraints)
  end

  puts sum
end


def power(game)
  game["red"] * game["green"] * game["blue"]
end

def part2
  input = read_file('day2_input.txt')
  sum = 0

  input.each do |game|
    sum += power(game)
  end
  puts sum
end

part2

