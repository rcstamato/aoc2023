
# ler o arquivo e obter as mãos e apostas
f = File.open("day7_input.txt")

input = f.readlines.map(&:chomp)

hands_and_bids = input.map { |line| line.split(" ") }

# Classificar uma mão de acordo com a sua força
def count_cards(hand)
  counter = {}
  hand.chars.each do |card|
    if counter[card].nil?
      counter[card] = 1
    else
      counter[card] += 1
    end
  end
  counter
end

def classify_hand(hand)
  # AAA23
  counter = count_cards(hand) # {"A" => 3, "2" => 1, "3" => 1}
  ordered_counter = counter.values.sort.reverse # [3,1,1]
  case ordered_counter[0]
  when 5 then :five
  when 4 then :four
  when 3 # [3,2], [3,1,1]
    ordered_counter[1] == 2 ? :full_house : :three
  when 2 #[2,2,1], [2,1,1,1]
    ordered_counter[1] == 2 ? :two_pair : :pair
  else
    :single
  end
end

def classify_with_joker(hand)
  return classify_hand(hand) unless hand.include?("J")

  counter = count_cards(hand)
  ordered_counter = counter.values.sort.reverse # [3,1,1]
  case ordered_counter[0]
  when 5 then :five
  when 4 then :five      #JJJJ1, 1111J
  when 3
    ordered_counter[1] == 2 ? :five : :four
  when 2
    if ordered_counter[1] == 2
      if counter['J'] == 2
        :four
      else
        :full_house
      end
    else
      :three
    end
  else
    :pair
  end
end

# classificar as apostas da menos valiosa pra mais valiosa
@hand_strenghts = {
  single: 0,
  pair: 1,
  two_pair: 2,
  three: 3,
  full_house: 4,
  four: 5,
  five: 6
}

#3AAA23 2JJ123
def convert_cards(hand)
  hand.gsub("A", "e").gsub("K", "d").gsub("Q", "c").gsub("J", "b").gsub("T", "a")
end

def convert_cards_part2(hand)
  hand.gsub("A", "e").gsub("K", "d").gsub("Q", "c").gsub("J", "1").gsub("T", "a")
end

# cálculo dos ganhos das apostas
def solve_part1(hands_and_bids)
  classified_hands = hands_and_bids.map do |hb| #["AAA23", 356]
    hand = hb[0]
    strength = classify_hand(hand)
    converted_cards = convert_cards(hand)
    ["#{@hand_strenghts[strength]}#{converted_cards}", hb[1]]
  end
  # [["3eee23", 356], ["233145", 128]]

  sorted_hands = classified_hands.sort do |hand1, hand2|
    hand1[0].hex <=> hand2[0].hex
  end

  sum = 0

  sorted_hands.each_with_index do |hand, idx|
    sum += (idx+1) * hand[1].to_i
  end

  puts "Part 1 is: #{sum}"
end

def solve_part2(hands_and_bids)
  classified_hands = hands_and_bids.map do |hb| #["AAA23", 356]
    hand = hb[0]
    strength = classify_with_joker(hand)
    converted_cards = convert_cards_part2(hand)
    ["#{@hand_strenghts[strength]}#{converted_cards}", hb[1]]
  end
  # [["3eee23", 356], ["233145", 128]]

  sorted_hands = classified_hands.sort do |hand1, hand2|
    hand1[0].hex <=> hand2[0].hex
  end

  sum = 0

  sorted_hands.each_with_index do |hand, idx|
    sum += (idx+1) * hand[1].to_i
  end

  puts "Part 2 is: #{sum}"
end

solve_part2(hands_and_bids)