require 'line'
require 'word'

class Reader
  attr_accessor :words
  attr_accessor :lines

  def initialize
    @words = Array.new
    @lines = Array.new
  end

  def parse(line)
    lineObject = Line.new
    line.scan(/[a-zA-Z']+/) do |w| 
      word = Word.new(w.upcase)
      @words.push(word)
      lineObject.append(word)
    end

    @lines.push(lineObject)
  end

  def to_html     
    dictionary = Dictionary.instance
    output = String.new
    first = TRUE
    @lines.each do |line|
      len = line.words.length
      n = 0
      
      syllablesRow = String.new
      wordsRow = String.new

      len.times do
        entry = dictionary.lookup(line.words[n].characters)
        if nil != entry
          i = 0
          syllables = entry.syllables.split(/\//)
          syllables.each do |s|
            syllablesRow << "  <td>" << entry.ranks[i] << "\n"
            wordsRow << "  <td>" << s << "\n"
            i += 1

          end
          
        else 
          syllablesRow << "  <td>notfound\n"
          wordsRow << "  <td>" << line.words[n].characters.to_s << "\n"

        end
        
        n += 1
      end

      if first 
        first = FALSE
      else
        output << "<p>\n"
      end
      
      output << "<table>\n"
      output << "<tr align=center>\n"
      output << syllablesRow
      output << "</tr>\n"
      output << "<tr>\n"
      output << wordsRow
      output << "</tr>\n"
      output << "</table>\n"

    end
    
    return output
  end
end

