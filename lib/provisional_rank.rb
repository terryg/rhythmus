require 'parse_step_decorator'
require 'dictionary'
require 'syllable'

class ProvisionalRank < ParseStepDecorator
  attr_accessor :parse_step
  
  def initialize(parse_step)
    @parse_step = parse_step
  end
  
  def parse()
    lines = @parse_step.parse

    t = Timer.new
    print "ProvisionalRank.parse\n"
    
    dictionary = Dictionary.instance
    
    lines.each do |line|  
      line.words.each do |word|
        entry = dictionary.lookup(word.characters)
        if nil != entry
          i = 0
          syllables = entry.syllables.split(/\//)
          syllables.each do |s|
            rank = entry.ranks[i,1] 
            word.syllables << Syllable.new(s, rank.to_i)
            i += 1
          end
        end
      end     
    end
    
    print "\t" + t.elapsed + "\n\n"
    
    return lines
  end
  
end 