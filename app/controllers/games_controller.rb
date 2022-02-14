require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    #Recupere la réponse
    @words = params[:word]
    @grid = params[:grid]
    if !good_answer
      @result = "Sorry but #{@words} can't be build out of #{@grid}"
    elsif !english_word
      @result = "Sorry but #{@words} is not a valid English word..."
    elsif good_answer && english_word
      @result = "Congratulations! #{@words} is a valid English word!"
    end
  end

  def good_answer
    @words.split('').all? {|letter| @grid.include?(letter)}
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@words}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    user['found']
  end

end
