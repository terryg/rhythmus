require 'glyph'

class Word < Glyph
  attr_accessor :characters

  def initialize
    @characters = Array.new
  end

  def append(character)
    @characters << character
  end

end
