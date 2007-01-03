require 'parse_step_decorator'
require 'dictionary'
  
class GuessMeter < ParseStepDecorator
  attr_accessor :parse_step
  
  def initialize(parse_step)
    @parse_step = parse_step
  end
  
  def parse()
    lines = @parse_step.parse

    t = Timer.new
    print "GuessMeter.parse\n"
        
    crests = 0
    syllables = 0
    syllablesAverage = 0
    
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

    avg = syllables.to_f/lines.size.to_f
    proper = avg
     
    if "duple" == guess 
      proper = (proper.to_f / 2.to_f).round
    else 
      proper = (proper.to_f / 3.to_f ).round   
    end    
    
    tally = Line.new
    tally.append(Word.new("TALLY"))
    tally.append(Word.new("c/s:"))
    tally.append(Word.new(("%.2f" % ratio)))
    tally.append(Word.new("[" + guess + "]"))
    tally.append(Word.new("s/l:"))
    tally.append(Word.new(("%.2f" % avg)))
    tally.append(Word.new("proper metrical stress:"))
    tally.append(Word.new(proper.to_s))
    
    lines<< tally

    print "\t" + t.elapsed + "\n\n"
        
    return lines
  end 
  
end 