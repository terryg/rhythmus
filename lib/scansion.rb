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
      cf = CharacterFactory.new
      line.scan(/[a-zA-Z']+/) do |w| 
        @words.push(Word.new(w.upcase))
      end
    end
  end

end
