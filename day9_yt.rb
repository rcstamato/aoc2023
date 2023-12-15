input = File.open("day9_input.txt").readlines.map(&:chomp)
@histories = input.map { |line| line.split(" ").map(&:to_i) }


def deltas(arr)
  delta = []
  1.upto(arr.count-1) do |i|
    delta << arr[i] - arr[i-1]
  end
  delta
end

def next_val(arr)
  d = deltas(arr)
  return arr[-1] if d.all?(&:zero?)

  arr[-1] + next_val(d)
end


def solve_part_1
  vals = @histories.map do |history|
    next_val(history)
  end
  vals.sum
end

def solve_part_2
  vals = @histories.map do |history|
    next_val(history.reverse)
  end
  vals.sum
end

p solve_part_2