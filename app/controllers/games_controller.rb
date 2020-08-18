require "open-uri"
class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @score = 0
    @message = ''
    @word = params[:word]
    @grid = params[:letters].split
    
    @word.split('').each do |letter|
      if @grid.include? letter
        @grid.delete_at(@grid.index(letter))
      else
        @message = "Sorry but #{@word} can't be built out of #{@grid.join(', ')}"
        return
      end
    end
    
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @result = JSON.parse(open(url).read)

    if @result['found']
      @score = @result['length']
      @message = "Congratulations! #{@word} is a valid English word!"
    else
      @message = "Sorry but #{@word} does not seem to be a valid English word..."
    end
  end
end
