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

def solve_part2_mmc
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

def solve_part2_brute_force
  start = Time.now
  steps = 0
  node_list = @adjacency_list.keys.select { |k| k[2]=="A" }
  loop do
    idx = steps % @commands.chars.length
    command = @commands[idx]
    node_list.each_with_index do |node,idx|
      node_list[idx] = command == "L" ? @adjacency_list[node][0] : @adjacency_list[node][1]
    end
    break if node_list.all? { |node| node[2]=="Z" }
    steps +=1
  end
  puts "#{steps+1} - #{Time.now - start}" if steps % 1_000_000 == 0
end


def part2_analysis
  node_list = @adjacency_list.keys.select { |k| k[2]=="A" }
  number_of_steps = []
  node_list.each_with_index do |node, ghost|
    start_node = node
    steps = 0
    loop do
      steps += 1
      idx = (steps-1) % @commands.chars.length
      command = @commands[idx]
      node = command == "L" ? @adjacency_list[node][0] : @adjacency_list[node][1]
      if node[2] == "Z"
        puts "Step #{steps} - Ghost #{ghost}, who started at node #{start_node}, reached node #{node}"
      end
      break if steps >= 50_000
    end
    number_of_steps << steps
  end

  p number_of_steps
  p number_of_steps.reduce(1, :lcm)
end

part2_analysis