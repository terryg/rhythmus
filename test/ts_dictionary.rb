$:.unshift 'lib'
require 'reader'
require 'dictionary'
require 'test/unit'

class DictionaryTest < Test::Unit::TestCase

  def setup
    dictionary = Dictionary.instance
    dictionary.load("test/test.dict")
  end

  def test_find
    dictionary = Dictionary.instance
    
    assert( dictionary.find?("ABLE") )

    assert( !dictionary.find?("ABRACADABRA") )
  end

 def test_to_dict
   dictionary = Dictionary.instance
   
   test = IO.readlines("test/test.dict")
    
   buffer = String.new
   dictionary.to_dict(buffer)
   
   assert( buffer == test.to_s )
 end
 
end
