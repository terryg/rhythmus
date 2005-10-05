$:.unshift 'lib'
require 'scansion'
require 'dictionary'
require 'test/unit'

include Scansion

class ScansionTest < Test::Unit::TestCase

  def setup
    @reader = Scansion::Reader.new
  end

  def test_parse
    @reader.parse( "Able was I ere I saw Elba." )
    assert( 7 == @reader.words.size )
  end

  def test_lookup
    dictionary = Dictionary.instance

    dictionary.load("test/test.dict")

    @reader.parse( "Able was I ere I saw Elba." )
    assert( 7 == @reader.words.size )

    assert( @reader.words[0].found? )
    assert( @reader.words[1].found? )
    assert( @reader.words[2].found? )
    assert( @reader.words[3].found? )
    assert( @reader.words[4].found? )
    assert( ! @reader.words[5].found? )
    assert( @reader.words[6].found? )
  end

  def test_lookup_file
    dictionary = Dictionary.instance

    dictionary.load("test/test.dict")

    f = File.new("test/the_turtle-nash.txt")
    
    f.each_line do |line|
      @reader.parse(line)
    end

    assert( 26 == @reader.words.size )

    @reader.words.each do |w|
      assert( w.found? )
    end
  end
end
