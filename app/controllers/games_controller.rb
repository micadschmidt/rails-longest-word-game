require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }
    @letters
  end

  # The method returns true if the block never returns false or nil

  def score
    @grid = params[:grid]
    @answer = params[:word]
    @dictonary = english_word(@answer)
    @user_grid = letter_in_grid(@answer, @grid)
    # if dictonary || user_grid
    #   "Congratulations #{@answer} is a valid English word"
    # end
  end

  private

  def english_word(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    word_dictionary = URI.open(url).read
    word = JSON.parse(word_dictionary)
    word['found']
  end

  def letter_in_grid(answer, grid)
    answer.chars.all? { |letter| answer.count(letter) <= grid.count(letter) }
  end
end
