require 'pry'
class Scrabble

  def score(word)
    value = 0
    if word.class == String && word.length != 0
      value += find_array_of_values(word).sum
      value += 10 if word.length > 6
    end
    value
  end

  def find_array_of_values(word)
    value_array = []
    split_characters = word.split('')
    split_characters.each do |character|
      value_array << point_values[character.upcase]
    end
    value_array
  end


  def score_with_multipliers(word, letter_multipliers, word_multiplier = 1)
    value_array = find_array_of_values(word)
    letter_values_with_multipliers = value_array.zip(letter_multipliers)
    total_letter_scores = letter_values_with_multipliers.map do |value|
      value[0]*value[1]
    end.sum
    total_letter_scores += 10 if word.length > 6
    total_letter_scores * word_multiplier
  end

  def highest_scoring_word(array)
    array.sort_by! {|word| word.length}.reverse
    scores = {}
    array.map do |word|
      scores[score(word)] = word
    end
    scores[scores.keys.max]
  end

  def point_values
    {
      "A"=>1, "B"=>3, "C"=>3, "D"=>2,
      "E"=>1, "F"=>4, "G"=>2, "H"=>4,
      "I"=>1, "J"=>8, "K"=>5, "L"=>1,
      "M"=>3, "N"=>1, "O"=>1, "P"=>3,
      "Q"=>10, "R"=>1, "S"=>1, "T"=>1,
      "U"=>1, "V"=>4, "W"=>4, "X"=>8,
      "Y"=>4, "Z"=>10
    }
  end
end
