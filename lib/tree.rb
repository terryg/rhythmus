require 'node'

class Tree

  attr_accessor :root

  attr_accessor :max
  attr_accessor :min  


  def initialize(min = 5, max = 11)
    @root = nil
    @max =max
    @min = min
  end
    
  def insert(entry)
    moveup = false
    right = nil
    
    moveup, newEntry, right = push_down(entry, @root)
    
    if moveup
      @root = Node.new(newEntry, @root, right)
    end
    
    return true
  end
  
  def retrieve(search)
    current = @root
    location = 0
    entry = nil
    
    while not current.nil? and entry.nil?
      found, location = current.search(search)  
      if found
        entry = current.entries[location]
      else
        current = current.branches[location + 1]
      end
    end
    
    return entry  
  end
  
  def to_dict(io = $defout)
    @root.to_dict(io)  
  end
  
  def dump
    @root.dump
  end  
  
  protected
  private
  
  def push_down(entry, node)
    current = node
    moveup = false
    newRight = nil
    newEntry = nil
    location = 0
    
    if (nil == node)
      moveup = true
      newEntry = entry
      newRight = nil
    else
      found, location = node.search(entry.word.upcase)
      if found
        # not good
      else  
        moveup, newEntry, newRight = push_down(entry, node.branches[location + 1])
      end
      
      if moveup
        if node.count < @max
          moveup = false
          node.add(newEntry, newRight, location + 1)
        else
          moveup = true
          newEntry, newRight = split(newEntry, newRight, node, location)
        end      
      end    
    end
    
    [moveup, newEntry, newRight]
  end
  
  def split(entry, right, node, location)
    newRight = Node.new(entry, nil, nil)
    
    median = @min + 1
    if location < @min
      median = @min
    end
    
    num = median
    while num < @max
      newRight.keys[num - median] = node.keys[num]
      newRight.entries[num - median] = node.entries[num]
      newRight.branches[num - median + 1] = node.branches[num + 1]
      num = num + 1
    end

   newRight.count = @max - median  
   node.count = median

   if (location < @min)
      node.add(entry, right, location + 1);
   else
      newRight.add(entry, right, location - median + 1)
   end
   
   newEntry = node.entries[node.count - 1]
   newRight.branches[0] = node.branches[node.count]
   node.count = node.count - 1
   
   [newEntry, newRight]
  end

end