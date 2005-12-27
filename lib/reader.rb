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

      scount = 0.0
      rtotal = 0

      len.times do
        entry = dictionary.lookup(line.words[n].characters)
        if nil != entry
          i = 0
          syllables = entry.syllables.split(/\//)
          syllables.each do |s|
            rank = entry.ranks[i]
            rtotal += (rank - 48)
            syllablesRow << "  <td>" << rank.to_i << "\n"
            wordsRow << "  <td>" << s << "\n"
            scount += 1
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


      syllablesRow << "<td><b>r/s: " << ("%.2f" % (rtotal / scount)) << "</b></td>\n"
      wordsRow << "<td></td>\n"

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

