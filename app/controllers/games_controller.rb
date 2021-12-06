class GamesController < ApplicationController
  require "open-uri"

  def new
    @newgames = [*('A'..'Z')].sample(10)
  end

  def score
    @letters = params[:newgames].split
    @word = (params[:words] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
