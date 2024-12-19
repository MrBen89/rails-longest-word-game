class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    require 'open-uri'
    url = "https://dictionary.lewagon.com/"
    html_content = URI.parse("#{url}#{params[:word]}").read
    doc = JSON.parse(html_content)
    p params
    word_in_letters = true
    params[:word].upcase.chars.each do |letter|
      unless params[:letters].include? letter
        word_in_letters = false
      end
    end
    session[:score] = 0 unless session[:score]

    if word_in_letters == false
      @message = "#{params[:word]} can't be made with those letters."
    elsif doc["found"] == false
      @message = "#{params[:word]} is not a valid word!"
    else
      session[:score] += doc["length"].to_i * doc["length"].to_i
      @message = "#{params[:word]} is worth #{doc["length"].to_i * doc["length"].to_i} points. Your total score is #{session[:score]}"
    end
  end
end
