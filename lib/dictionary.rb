require 'entry'
require 'singleton'
require 'timer'
require 'tree'

class Dictionary
  include Singleton

  attr_accessor :tree
  
  def initialize
    @tree = Tree.new
  end

  def load(filename)    
    t = Timer.new
    
    printf "Dictionary.load\n"
    
    if !File.exists?(filename)
      File.new(filename, File::CREAT|File::TRUNC|File::RDWR, 0644)
    end

    print "\tfile read: " + t.elapsed + "\n"
            
    IO.foreach(filename) {|x| 
      entry = x.split(/ /)
      add(entry[0], entry[1].strip)
    }
    
    print "\tadded entries: " + t.elapsed + "\n\n"
    
  end

  def lookup(word)
    return @tree.retrieve(word.to_s.upcase)
  end

  def find?(word)
     return (not @tree.retrieve(word.to_s.upcase).nil?)
  end

  def add(syllables, ranks)
    word = syllables.gsub(/\//, '')
    entry = Entry.new(word, syllables, ranks)
 
    @tree.insert(entry)    
  end

  def to_dict(io = $defout)
    @tree.to_dict(io)
  end
  
end
