require 'word'
require 'character_factory'

#
#= Usage
#
module Scansion

  class Reader
    attr_accessor :words

    def initialize
      @words = Array.new
    end

    def parse(line)
      word = Word.new
      cf = CharacterFactory.new
      line.each_byte do |x| 
        character = cf.getCharacter(x)
        if !character.is?(32) 
          word.append(character)
        else
          @words.push(word)
          word = Word.new
        end
      end

      @words.push(word)

    end
  end

end
