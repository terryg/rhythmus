require 'word'

class Line
  attr_accessor :words

  def initialize()
    @words = Array.new
  end

  def append(word)
    @words << word
  end

end

