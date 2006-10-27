$:.unshift("lib")
require 'reader'
require 'dictionary'
require 'provisional_rank'
require 'provisional_stress'
require 'demote_stress'
require 'promote_stress'
require 'guess_meter'
require 'test/unit'

class GuessMeterTest < Test::Unit::TestCase

  def setup
    @reader = Reader.new
  end

  def test_demote
    dictionary = Dictionary.instance

    dictionary.load("test/test.dict")

    @reader = Reader.new()

    @reader.addline("and on the washy oose deep channels wore");
   
    @reader = ProvisionalRank.new(@reader)
    @reader = ProvisionalStress.new(@reader)
    @reader = DemoteStress.new(@reader)
    @reader = PromoteStress.new(@reader)
    @reader = GuessMeter.new(@reader)

    lines = @reader.parse
    
    lines.each do |line|
      line.words.each do |word|
        print word.characters
        print "\n"       
      end
    end
    
    assert(lines.size == 2)
    
    assert(lines[1].words[0].characters == "**TALLY**")
    assert(lines[1].words[1].characters == "5")
    assert(lines[1].words[2].characters == "crests")
    assert(lines[1].words[3].characters == "10")
    assert(lines[1].words[4].characters == "syllables")
    assert(lines[1].words[5].characters == "0.5")
    assert(lines[1].words[6].characters == "duple")
  end

end
