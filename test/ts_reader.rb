$:.unshift("lib")
require 'reader'
require 'dictionary'
require 'test/unit'

class ReaderTest < Test::Unit::TestCase

  def setup
    @reader = Reader.new   
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

  def test_lookup_file_and_query
    dictionary = Dictionary.instance

    dictionary.load("test/test.dict")

    f = File.new("test/the_eel-nash.txt")
    
    f.each_line do |line|
      @reader.parse(line)
    end

    assert( 12 == @reader.words.size )

    @reader.words.each do |w|
      if !w.found?
        dictionary.add("eels", "3")
      end
    end

    @reader.words.each do |w|
      assert( w.found? )
    end

  end

  def test_writeout
    dictionary = Dictionary.instance

    dictionary.load("test/test.dict")

    ftxt = File.new("test/the_turtle-nash.txt")
    
    ftxt.each_line do |line|
      @reader.parse(line)
    end

    output = @reader.to_html

    fhtml = IO.readlines("test/the_turtle-nash.html")
    
    assert( output.to_s == fhtml.to_s )
  end
end