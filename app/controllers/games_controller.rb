require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
    # session[:letters] = @letters
  end

  def score
    # raise
    @letters = params[:letters].upcase
    @word = params[:word].upcase
    url = "https://dictionary.lewagon.com/#{params[:word]}"
    score_serialized = URI.parse(url).read
    score = JSON.parse(score_serialized)

    if score["found"] == true
      if @word.split("").all? { |letter|  @letters.include?(letter)}
        @result = "Congratulations! #{@word} is a valid English word!"
      else
        @result = "Sorry but #{@word} can't be built with #{@letters}"
      end
    else
      @result = "Sorry but #{@word} does not seem to be a valid English word..."
    end
  end
end
