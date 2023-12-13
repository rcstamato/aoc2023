
input = File.open("day9_input.txt").readlines.map(&:chomp)
@histories = input.map { |line| line.split(" ").map(&:to_i) }

# history = %w[10 13 16 21 30 45].map(&:to_i)

def deltas(arr)
  arr.each_with_index.map { |n, i| n - arr[i - 1] if i.positive? }.compact
end

def next_val(arr)
  d = deltas(arr)
  return arr[-1] if d.all?(&:zero?)

  next_val(d) + arr[-1]
end

def solve_part_1
  vals = @histories.map do |history|
    sol = next_val(history)
    p "#{history}: #{sol}"
    sol
  end

  vals.sum
end

def solve_part_2
  vals = @histories.map do |history|
    sol = next_val(history.reverse)
    p "#{history}: #{sol}"
    sol
  end

  vals.sum
end

p solve_part_2