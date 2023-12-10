@some_number = 1

def change_it
  @some_number = 4
end

puts @some_number
change_it
puts @some_number
puts self.class

