require 'singleton'

class Dictionary
  include Singleton

  attr_accessor :entries

  def initialize
    @entries = Hash.new
  end

  def load(filename)    
    IO.foreach(filename) {|x| 
      @entries[x.strip.upcase] = x.strip.upcase
    }
  end

  def find?(word)
    return (nil == @entries[word.to_s]) ? FALSE : TRUE
  end
end
