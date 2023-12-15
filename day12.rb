input = File.open("day12_input.txt").readlines.map(&:chomp)

input = input.map do |line|
  springs, counts = line.split(" ")
  count_arr = counts.split(",").map(&:to_i)
  [springs, count_arr]
end

# para cada linha
# # rodar todas as combinacoes de . e # possiveis
# # calcular counter da combinacao
# # se counter bater com o counter informado no input, incrementar um contador para a linha

def get_counter(str)
  str.scan(/#+/).map(&:length)
end

def valid_combinations(str, counters)
  valid_combinations = []
  w_idx = wildcards_indexes(str)
  combinations = ["#", "."].repeated_permutation(w_idx.count).to_a
  combinations.each_with_index do |combination, idx|
    str_copy = str.dup
    combination.each_with_index { |c, i| str_copy[w_idx[i]] = c }
    comb_counter = get_counter(str_copy)
    valid_combinations << str_copy if comb_counter == counters
  end

  valid_combinations
end

def wildcards_indexes(str)
  str.chars.each_with_index.map { |c, i| i if c=="?"}.compact
end

def solve_part_1(input)
  line_counter = 0
  counts = input.map do |line|
    nn = valid_combinations(*line).count
    p line_counter
    line_counter += 1
    nn
  end
  counts.sum
end

def solve_part_2(input)
  line_counter = 0
  counts = input.map do |line|
    str, counter = line
    single_count = valid_combinations(str, counter).count
    unfolded_str = (Array(str)*2).join("?")
    unfolded_counter = counter * 2
    double_count = valid_combinations(unfolded_str, unfolded_counter).count
    factor = double_count / single_count
    total = single_count * factor**4

    p "#{line_counter}: #{total}"
    line_counter += 1
    total
  end
  counts.sum
end

p solve_part_2(input)