require 'parse_step_decorator'
require 'dictionary'

class ProvisionalStress < ParseStepDecorator
  attr_accessor :parse_step
  
  def initialize(parse_step)
    @parse_step = parse_step
  end
  
  def parse()
    lines = @parse_step.parse
    
    dictionary = Dictionary.instance
    
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
    
    return lines
  end
  
end 