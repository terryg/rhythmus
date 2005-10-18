$:.unshift 'lib'
require 'scansion'
require 'dictionary'
require 'test/unit'

include Scansion

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
