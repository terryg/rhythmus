require 'entry'
require 'singleton'

class Dictionary
  include Singleton

  attr_accessor :entries

  def initialize
    @entries = nil
  end

  def load(filename)    
    IO.foreach(filename) {|x| 
      entry = x.split(/ /)
      add(entry[0], entry[1])
    }
  end

  def find?(word)
    found = FALSE
    entry = @entries

    loop do
      if entry == nil
        break
      end

      if entry.word == word.to_s
        found = TRUE
        break
      end
      
      entry = entry.next
    end

    return found
  end

  def add(syllables, ranks)
    word = syllables.sub(/\//, '')
    if nil == word 
      word = syllables
    end
    entry = Entry.new(word, syllables, ranks)
    entry.next = @entries
    @entries = entry
  end

end
