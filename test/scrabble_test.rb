gem 'minitest'
require_relative '../lib/scrabble'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class ScrabbleTest < Minitest::Test
  def test_it_can_score_a_single_letter
    assert_equal 1, Scrabble.new.score("a")
    assert_equal 4, Scrabble.new.score("f")
  end

  def test_it_can_score_a_word
    assert_equal 8, Scrabble.new.score("hello")
    assert_equal 9, Scrabble.new.score("world")
  end

  def test_it_can_score_an_empty_string
    assert_equal 0,Scrabble.new.score("")
  end

  def test_it_does_not_fail_when_recieving_nil
    assert_equal 0, Scrabble.new.score(nil)
  end

  def test_it_can_score_with_multipliers
    assert_equal 9, Scrabble.new.score_with_multipliers("world", [1,1,1,1,1])
    assert_equal 13, Scrabble.new.score_with_multipliers("world", [2,1,1,1,1])
    assert_equal 26, Scrabble.new.score_with_multipliers("world", [2,1,1,1,1], 2)
    assert_equal 8, Scrabble.new.score_with_multipliers("hello", [1,1,1,1,1])
    assert_equal 10, Scrabble.new.score_with_multipliers("hello", [1,1,2,1,2])
    assert_equal 30, Scrabble.new.score_with_multipliers("hello", [1,1,2,1,2], 3)
  end

  def test_it_assigns_bonus_points_for_length
    assert_equal 8, Scrabble.new.score("hello")
    assert_equal 9, Scrabble.new.score("world")
    assert_equal 27, Scrabble.new.score("helloworld")
    assert_equal 8, Scrabble.new.score_with_multipliers("hello", [1,1,1,1,1])
    assert_equal 9, Scrabble.new.score_with_multipliers("world", [1,1,1,1,1])
    assert_equal 27, Scrabble.new.score_with_multipliers("helloworld", [1,1,1,1,1,1,1,1,1,1])
    assert_equal 12, Scrabble.new.score_with_multipliers("hello", [1,2,1,3,2])
    assert_equal 14, Scrabble.new.score_with_multipliers("world", [1,2,1,3,2])
    assert_equal 36, Scrabble.new.score_with_multipliers("helloworld", [1,2,1,3,2,1,2,1,3,2])
    assert_equal 48, Scrabble.new.score_with_multipliers("hello", [1,2,1,3,2], 4)
    assert_equal 28, Scrabble.new.score_with_multipliers("world", [1,2,1,3,2], 2)
    assert_equal 108, Scrabble.new.score_with_multipliers("helloworld", [1,2,1,3,2,1,2,1,3,2], 3)
  end

  def test_it_can_choose_the_highest_scoring_word
    assert_equal "sparkle", Scrabble.new.highest_scoring_word(["hello", "world", "ball", "game", "sparkle"])
    assert_equal "silence", Scrabble.new.highest_scoring_word(["home", "word", "silence"])
    assert_equal "now", Scrabble.new.highest_scoring_word(["ball", "now", "car"])
    assert_equal "word", Scrabble.new.highest_scoring_word(["hi", "word", "ward"])
  end
end
