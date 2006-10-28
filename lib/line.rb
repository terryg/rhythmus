require 'word'

class Line
  attr_accessor :words

  def initialize()
    @words = Array.new
  end

  def append(word)
    @words << word
  end

  def wordcount
    @words.size
  end

  def syllablecount
    syllables = 0
    @words.each do |word|
      syllables = syllables + word.syllables.count
    end
    return syllables
  end
  
end

