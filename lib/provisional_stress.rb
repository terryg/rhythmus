require 'parse_step_decorator'

class ProvisionalStress < ParseStepDecorator
  attr_accessor :parse_step
  
  def initialize(parse_step)
    @parse_step = parse_step
  end
  
  def parse()
    lines = @parse_step.parse

    t = Timer.new   
    print "ProvisionalStress.parse\n"
     
    lines.each do |line|
      line.words.each do |word|
        word.syllables.each do |s|
          if 3 == s.rank
            s.stressed = true
          else
            s.stressed = false
          end
        end
      end     
    end
    
    print "\t" + t.elapsed + "\n\n"
    
    return lines
  end
  
end 