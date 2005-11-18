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

end
