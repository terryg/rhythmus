$:.unshift 'lib'
require 'node'
require 'tree'
require 'test/unit'

class TreeTest < Test::Unit::TestCase

  def setup
  
  
  end

  def test_add
    tree = Tree.new(2, 4)
    
#    for letter in ['A','C','G','N','H']
   for letter in 'A'..'Z'
      tree.insert(Entry.new(letter, letter, 1))     
    end
    
    tree.dump
  end

  def test_dump
  end
 
end
