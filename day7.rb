@hand_strenghts = {
  single: 0,
  pair: 1,
  two_pair: 2,
  three: 3,
  full_house: 4,
  four: 5,
  five: 6
}

def classify_hand(hand)
  counter = count_cards(hand)
  case counter[0]
  when 5; :five
  when 4; :four
  when 3
    counter[1] == 2 ? :full_house : :three
  when 2
    counter[1] == 2 ? :two_pair : :pair
  else
    :single
  end
end

def count_cards(hand)
  count_hash(hand).values.sort.reverse
end

def count_hash(hand)
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

def convert_cards(hand)
  hand.gsub("A", "e").gsub("K", "d").gsub("Q", "c").gsub("J", "b").gsub("T", "a")
end

def convert_cards_part2(hand)
  hand.gsub("A", "e").gsub("K", "d").gsub("Q", "c").gsub("J", "1").gsub("T", "a")
end

def classify_with_jokers(hand)
  return classify_hand(hand) unless hand.include?("J")

  counter = count_cards(hand)
  count_hash = count_hash(hand)

  strenght = case counter[0]
             when 5 then :five
             when 4 then :five
             when 3
               counter[1] == 2 ? :five : :four
             when 2
               if counter[1] == 2
                 if count_hash['J'] == 2
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

  puts("#{hand} - #{strenght}")

  strenght
end


def solve_part1
  f = File.open("day7_input.txt")

  lines = f.readlines.map(&:chomp)

  hands_and_bids = lines.map { |l| l.split(" ") }

  classified_hands = hands_and_bids.map do |hb|
    hand = hb[0]
    strength = classify_hand(hand)
    converted_cards = convert_cards(hand)
    ["#{@hand_strenghts[strength]}#{converted_cards}", hb[1]]
    end

  sorted_hands = classified_hands.sort do |hand_1, hand_2|
    hand_1[0].hex <=> hand_2[0].hex
  end

  sum = 0

  sorted_hands.each_with_index do |hand, idx|
    sum += (idx+1) * hand[1].to_i
  end

  puts sum
end

def solve_part2
  f = File.open("day7_input.txt")

  lines = f.readlines.map(&:chomp)

  hands_and_bids = lines.map { |l| l.split(" ") }

  classified_hands = hands_and_bids.map do |hb|
    hand = hb[0]
    strength = classify_with_jokers(hand)
    converted_cards = convert_cards_part2(hand)
    ["#{@hand_strenghts[strength]}#{converted_cards}", hb[1]]
  end

  sorted_hands = classified_hands.sort do |hand_1, hand_2|
    hand_1[0].hex <=> hand_2[0].hex
  end

  sum = 0

  sorted_hands.each_with_index do |hand, idx|
    sum += (idx+1) * hand[1].to_i
  end

  puts sum
end

solve_part2