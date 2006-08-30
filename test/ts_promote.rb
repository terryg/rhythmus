$:.unshift("lib")
require 'reader'
require 'dictionary'
require 'provisional_rank'
require 'provisional_stress'
require 'demote_stress'
require 'promote_stress'
require 'test/unit'

class PromoteTest < Test::Unit::TestCase

  def setup
    @reader = Reader.new
  end
  
  def test_promote
    dictionary = Dictionary.instance

    dictionary.load("test/test.dict")

    @reader = Reader.new()

    @reader.addline("and on the washy oose deep channels wore");
   
    @reader = ProvisionalRank.new(@reader)
    @reader = ProvisionalStress.new(@reader)
    @reader = DemoteStress.new(@reader)
    @reader = PromoteStress.new(@reader)
        
    lines = @reader.parse
    
    assert( lines[0].words[0].syllables[0].rank == 1 )
    assert( lines[0].words[0].syllables[0].stressed == false )

    assert( lines[0].words[1].syllables[0].rank == 2 )
    assert( lines[0].words[1].syllables[0].stressed == true )        

    assert( lines[0].words[2].syllables[0].rank == 1 )
    assert( lines[0].words[2].syllables[0].stressed == false )

    assert( lines[0].words[3].syllables[0].rank == 2 )
    assert( lines[0].words[3].syllables[0].stressed == true )
    assert( lines[0].words[3].syllables[1].rank == 1 )
    assert( lines[0].words[3].syllables[1].stressed == false )
    
    assert( lines[0].words[4].syllables[0].rank == 3 )
    assert( lines[0].words[4].syllables[0].stressed == true )
    
    assert( lines[0].words[5].syllables[0].rank == 3 )
    assert( lines[0].words[5].syllables[0].stressed == false )
    
    assert( lines[0].words[6].syllables[0].rank == 3 )
    assert( lines[0].words[6].syllables[0].stressed == true )
    assert( lines[0].words[6].syllables[1].rank == 1 )
    assert( lines[0].words[6].syllables[1].stressed == false )
    
    assert( lines[0].words[7].syllables[0].rank == 3 )
    assert( lines[0].words[7].syllables[0].stressed == true )
  end  
end
