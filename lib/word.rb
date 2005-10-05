require 'glyph'

class Word < Glyph
  attr_accessor :characters

  def initialize(word)
    @characters = Array.new
    word.each do |c|
      @characters << c
    end
  end

  def append(character)
    @characters << character
  end

  def found?
    dictionary = Dictionary.instance
    return dictionary.find?(@characters)
  end

end

