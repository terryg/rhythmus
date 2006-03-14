require 'glyph'

class Word < Glyph
  attr_accessor :characters
  attr_accessor :syllables
  attr_accessor :stressed
  
  def initialize(word)
    @characters = Array.new
    word.each do |c|
      @characters << c
    end
    
    @syllables = Array.new
  end

  def append(character)
    @characters << character
  end

  def found?
    dictionary = Dictionary.instance
    return dictionary.find?(@characters)
  end

end

