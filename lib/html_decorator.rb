require 'parse_step_decorator'

class HtmlDecorator < ParseStepDecorator
  attr_accessor :parse_step

  def initialize(parse_step)
    @parse_step = parse_step
  end
  
  def parse()
    lines = parse_step.parse()

    t = Timer.new
    log "HtmlDecorator.parse\n"
        
    output = String.new
    first = true
      
    lastline = lines.pop
      
    lines.each do |line|
      rrow = String.new
      wrow = String.new
      
      scount = 0.0
      rtotal = 0
      
      line.words.each do |word|
        log word.to_s + "\t"
        
        word.syllables.each do |s|
          log s.unit + " "
          rrow << "  <td>" << s.rank.to_s << "</td>\n"
          rtotal += s.rank
          wrow << "  <td>" 
          if s.stressed
            wrow << s.unit.upcase
          else 
            wrow << s.unit.downcase
          end
          wrow << "</td>\n"
          
          scount += 1
        end
        
        log "\t"
      end

      if first 
        first = false
      else
        output << "<p>\n"
      end

      rrow << "<td><b>r/s: " << ("%.2f" % (rtotal / scount)) << "</b></td>\n"
      wrow << "<td></td>\n"

      output << "<table>\n"
      output << "<tr align=center>\n"
      output << rrow
      output << "</tr>\n"
      output << "<tr>\n"
      output << wrow
      output << "</tr>\n"
      output << "</table>\n"
   
      log "\n"
    end
    
    lastrow = String.new
    
    lastline.words.each do |w|
      lastrow<< w.characters.to_s
      lastrow<< " "
    end
    
    output << "<p><table>\n"
    output << "<tr align=center><th>\n"
    output << lastrow
    output << "</th></tr>\n"
    output << "</p></table>\n"
        
    log "\t" + t.elapsed + "\n\n"

    return output
  end
end