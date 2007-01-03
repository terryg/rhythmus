
MASKSET = {
  :keep => 1,
  :anycase => 2,
  :allcaps => 4, 
  :capitalized => 8, 
  :followcase => 16,
  :captypemask => 32,
  :morevariants => 64,
  :allflags => 128
}.freeze

class Entry
  attr_accessor :syllables
  attr_accessor :flags
  attr_accessor :ranks
  attr_accessor :word

  def initialize(word, syllables, ranks)
    @next = nil
#    @flags = whatcap(word)
    @word = word.upcase
    @syllables = syllables
    @ranks = ranks

#    if MASKSET:followcase != @flags 
#      @word = @word.upcase
#    end   
  end

  def whatcap(word)
    for ii in [0,word.length] do
      if word[ii,1] == word[ii,1].downcase
        break
      end
    end

    if ii == word.length
      return MASKSET::allcaps
    end

    for jj in [ii,word.length] do
      if word[jj,1] == word[jj,1].upcase
        break
      end
    end

    if jj == word.length
      if word[0,1] == word[0,1].upcase
        for kk in [1,word.length]
          if word[kk,1] == word[kk,1].upcase
            return MASKSET::followcase
          end
          return MASKSET::capitalized
        end
      else
        return MASKSET::anycase
      end 
    else     
      return MASKSET::followcase
    end
  end

end
