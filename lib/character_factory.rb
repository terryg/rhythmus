require 'character'

class CharacterFactory
  attr_accessor :characters

  def initialize
    @characters = Hash.new(nil)
  end

  def getCharacter( key )
    character = @characters[key]

    if nil == character 
      character = Character.new(key)
      @characters[key] = character
    end

    return character

  end
end
