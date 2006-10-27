require 'parse_step_decorator'
require 'dictionary'
  
class GuessMeter < ParseStepDecorator
  attr_accessor :parse_step
  
  def initialize(parse_step)
    @parse_step = parse_step
  end
  
  def parse()
    lines = @parse_step.parse
    
    crests = 0
    syllables = 0
    lines.each do |line|
      line.words.each do |word|
        last = false
        word.syllables.each do |syl|
          syllables = syllables + 1
          if (syl.stressed and not last)
            crests = crests + 1
            last = true
          else
            last = false
          end
        end
      end
    end
   
    guess = "triple"
    ratio = crests.to_f/syllables.to_f
    
    if ratio > 0.40
      guess = "duple"
    end
    
    tally = Line.new
    tally.append(Word.new("TALLY"))
    tally.append(Word.new(crests.to_s))
    tally.append(Word.new("crests"))
    tally.append(Word.new(syllables.to_s))
    tally.append(Word.new("syllables"))
    tally.append(Word.new(("%.2f" % ratio)))
    tally.append(Word.new(guess))

    lines<< tally
    
    return lines
  end 
  
end 