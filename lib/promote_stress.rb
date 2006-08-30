require 'parse_step_decorator'
require 'dictionary'

class PromoteStress < ParseStepDecorator
  attr_accessor :parse_step
  
  def initialize(parse_step)
    @parse_step = parse_step
  end
  
  def parse()
    lines = @parse_step.parse
    
    lines.each do |line|
      syls = Array.new
      
      npos = 0
      line.words.each do |word|
        word.syllables.each do |s|
          syls<< s.rank
          npos = npos + 1
        end
      end

      ii = 0
      line.words.each do |word|
        word.syllables.each do |s|
          if 0 == ii
          elsif npos == ii
          else   
            if 2 == syls[ii] && (1 == syls[ii - 1] || 2 == syls[ii - 1]) && (1 == syls[ii + 1] || 2 == syls[ii + 1])
              s.stressed = true
            end
          end
        
          ii = ii + 1
        end
      end
    end
   
    return lines
  end 
  
end 