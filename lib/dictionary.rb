require 'singleton'

class Dictionary
  include Singleton

  attr_accessor :entries

  def initialize
    @entries = Hash.new
  end

  def load(filename)    
    IO.foreach(filename) {|x| 
      entry = x.split(/ /)
      add(entry[0], entry[1])
    }
  end

  def find?(word)
    return (nil == @entries[word.to_s]) ? FALSE : TRUE
  end

  def add(word, syllables)
    @entries[word.strip.upcase] = syllables
  end

end
