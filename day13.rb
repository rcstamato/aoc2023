input = File.open("day13_input.txt").readlines.map(&:chomp)

patterns = []
current_pattern = []

input.each do |line|
  if line==""
    patterns << current_pattern
    current_pattern = []
  else
    current_pattern << line
  end
end

patterns << current_pattern

DIFF=1

def find_horizontal_mirror(pattern)
  1.upto(pattern.count-1) do |i|
    return 100*(i) if check_horizontal_mirror(pattern, i)
  end
  0
end

def check_horizontal_mirror(pattern, i)
  steps = [i, pattern.count-i].min
  diffs = 0
  steps.times do |s|
    diffs += compare(pattern[(i-1)-s].chars, pattern[i+s].chars)
  end
  diffs==DIFF
end

def find_vertical_mirror(pattern)
  1.upto(pattern.first.length-1) do |i|
    return i if check_vertical_mirror(pattern, i)
  end
  0
end

def check_vertical_mirror(pattern, i)
  steps = [i, pattern.first.length-i].min
  diffs = 0
  steps.times do |s|
    diffs += compare(pattern.map {|row| row[i-1-s]}, pattern.map{|row| row[i+s]})
  end
  diffs==DIFF
end

def compare(arr1, arr2)
  return false if arr1.count != arr2.count

  diffs = 0
  (0..arr1.count-1).each do |i|
    diffs += 1 unless arr1[i]==arr2[i]
  end

  diffs

end

sum = 0

patterns.each_with_index do |pattern, i|
  a = find_horizontal_mirror(pattern)
  if a==0
    a = find_vertical_mirror(pattern)
  end

  p "#{i}: #{a}"
  sum+=a
end

p sum