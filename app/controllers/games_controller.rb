require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    return @letters = (1..10).to_a.map { ("A".."Z").to_a.sample(1)[0] }
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters]
    url_string = URI.open("https://wagon-dictionary.herokuapp.com/#{@answer}").read
    check_dico = JSON.parse(url_string)["found"]
    check_grid = @answer.upcase.chars.all? {|letter| @answer.upcase.chars.count(letter) <= @letters.count(letter)}

    if check_grid == false
      @score = { score: 0, message: "not in the grid" }
    elsif check_dico == false
      @score = { score: 0, message: "not an english word"}
    else
      @score = { score: (@answer.size * 100), message: "well done" }
    end
  end
end
