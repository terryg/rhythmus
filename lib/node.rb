require 'entry'

class Node
  
  attr_accessor :count
  attr_accessor :keys
  attr_accessor :branches
  attr_accessor :entries

  def initialize(entry, left, right)
    @count = 1

    @keys = Array.new
    @keys[0] = entry.word.upcase
    
    @branches = Array.new
    @branches[0] = left
    @branches[1] = right
        
    @entries = Array.new
    @entries[0] = entry
  end
    
  def to_dict(io = $defout)
   for num in 0..(@count - 1).to_i
      @branches[num].to_dict(io) unless @branches[num].nil?      

      if not @entries[num].nil?
        io << @entries[num].syllables << " " << @entries[num].ranks << "\n"
      end      
    end

    @branches[num + 1].to_dict(io) unless @branches[num + 1].nil?      
  end
  
  def dump(depth = 0)
    for num in 0..(@count - 1).to_i
      @branches[num].dump(depth + 1) unless @branches[num].nil?
     
      if not @keys[num].nil?
        depth.times do
          print "\t"
        end
        
        print @keys[num] + "\n"
      end 
      
    end
    
    @branches[num + 1].dump(depth + 1) unless @branches[num + 1].nil?    
  end

  def add(entry, right, location)   
    num = @count
    while num > location
      @keys[num] = @keys[num - 1]
      @entries[num] = @entries[num - 1]
      @branches[num + 1] = @branches[num]
      num = num - 1
    end
    
    @keys[location] = entry.word.upcase
    @entries[location] = entry
    @branches[location + 1] = right
    
    @count += 1
  end
  
  def search(key)
    found = false
    location = 0
    
   if key < @keys[0]
      location = -1
   else
      location = @count - 1
      while key < @keys[location] and location > 0
         location = location - 1
      end
      
      if key == @keys[location]
        found = true
      end
    end
        
    return [found, location]
  end
    
end