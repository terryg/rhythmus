require 'glyph'

class Character < Glyph
  attr_accessor :charcode 

  def initialize( char )
    @charcode = char
  end

  def is?(char)
    result = false
    
    if char == @charcode
      result = true
    end

    return result
  end

end
