
times = [49979494]
records = [263153213781851]
won = [0]

0.upto(times.count - 1) do |i|
  time = times[i]
  1.upto(time) do |t|
    puts t if t % 100000 == 0
    velocity = t
    distance = velocity * (time - t)
    won[i] += 1 if distance > records[i]
  end
end

puts won.reduce { |w, prod| w*prod }