def read_file(filename)
  input_file = File.open(filename)
  input = input_file.readlines.map(&:chomp)
  input.map { |line| line.chars }
end


def solve_part1
  input = read_file("day3_input.txt")
  i = 0
  j = 0
  loop do # looping through lines
    loop do # looping chars within a line
      next unless (0..9).include? input[i][j]
      start_pos = j
      end_pos = j
      loop do
        j += 1
        next if (0..9).include? input[i][j]
        end_pos = j
      end
      number = input[i][start_pos..end_pos]

    end
    i += 1
  end
end