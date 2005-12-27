require 'entry'
require 'singleton'

class Dictionary
  include Singleton

  attr_accessor :entries

  def initialize
    @entries = nil
  end

  def load(filename)    
    if !File.exists?(filename)
      File.new(filename, File::CREAT|File::TRUNC|File::RDWR, 0644)
    end
    
    IO.foreach(filename) {|x| 
      entry = x.split(/ /)
      add(entry[0], entry[1].strip)
    }
  end

  def lookup(word)
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

    return entry
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
    word = syllables.gsub(/\//, '')
    entry = Entry.new(word, syllables, ranks)
    entry.next = @entries
    @entries = entry
  end

  def to_dict(io = $defout)
    entry = @entries

    loop do
      if entry == nil
        break
      end
      
      io << entry.syllables << " " << entry.ranks << "\n"
      
      entry = entry.next
    end
  end

end
