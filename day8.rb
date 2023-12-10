f = File.open("day8_input.txt")
input = f.readlines.map(&:chomp)

@commands = input[0]
vertices_list = input[2..]
@adjacency_list = {}
vertices_list.each do |line|
  split = line.split(" = ")
  split[1].scan(/\(([0-9A-Z]+),\s([0-9A-Z]+)\)/)
  @adjacency_list[split[0]] = [$1, $2]
end

def solve_part1
  steps = 0
  node = "AAA"
  loop do
    idx = steps % @commands.chars.length
    command = @commands[idx]
    node = command == "L" ? @adjacency_list[node][0] : @adjacency_list[node][1]
    break if node == "ZZZ"
    steps += 1
  end
  puts steps+1
end

def solve_part2
  node_list = @adjacency_list.keys.select { |k| k[2]=="A" }
  number_of_steps = []
  node_list.each do |node|
    steps = 0
    loop do
      idx = steps % @commands.chars.length
      command = @commands[idx]
      node = command == "L" ? @adjacency_list[node][0] : @adjacency_list[node][1]
      break if node[2] == "Z"
      steps += 1
    end
    number_of_steps << steps+1
  end

  p number_of_steps
  p number_of_steps.reduce(1, :lcm)
end

solve_part2