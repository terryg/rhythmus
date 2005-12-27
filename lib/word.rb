require 'glyph'

class Word < Glyph
  attr_accessor :characters
  attr_accessor :syllables

  def initialize(word)
    @characters = Array.new
    word.each do |c|
      @characters << c
    end
    
    syllables = 0

    dictionary = Dictionary.instance
    entry = dictionary.lookup(@characters)
    if nil != entry
      syl = entry.syllables.split(/\//)
      syl.each do |s|
        syllables += 1
      end
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

