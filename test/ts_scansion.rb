$:.unshift 'lib'
require 'scansion'
require 'test/unit'

include Scansion

class ScansionTest < Test::Unit::TestCase

  def setup
    @reader = Scansion::Reader.new
  end

  def test_parse
    @reader.parse( "Able was I ere I saw elba." )
    assert( 7 == @reader.words.size )
  end

end
