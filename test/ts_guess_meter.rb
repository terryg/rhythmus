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

  def test_guess_meter
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
    
    assert(lines.size == 2)
    
    assert(lines[1].words[0].to_s == "TALLY")
    assert(lines[1].words[1].to_s == "5")
    assert(lines[1].words[2].to_s == "crests")
    assert(lines[1].words[3].to_s == "10")
    assert(lines[1].words[4].to_s == "syllables")
    assert(lines[1].words[5].to_s == "0.50")
    assert(lines[1].words[6].to_s == "duple")
  end

end
