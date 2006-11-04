$:.unshift("lib")
require 'reader'
require 'dictionary'
require 'provisional_rank'
require 'provisional_stress'
require 'demote_stress'
require 'promote_stress'
require 'guess_meter'
require 'html_decorator'
require 'test/unit'

class ReaderTest < Test::Unit::TestCase

  def setup
    @reader = Reader.new
  end

  def test_addline
    @reader.addline( "Able was I ere I saw Elba." )
    assert( 7 == @reader.words.size )
  end

  def test_lookup
    dictionary = Dictionary.instance

    dictionary.load("test/test.dict")

    @reader.addline( "Able was I ere I saw Elba." )
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
   
    @reader.file = f

    @reader.parse

    assert( 26 == @reader.words.size )

    @reader.words.each do |w|
      assert( w.found? )
    end
  end

  def test_lookup_file_and_query
    dictionary = Dictionary.instance

    dictionary.load("test/test.dict")

    f = File.new("test/the_eel-nash.txt")
    
    @reader.file = f
    @reader.parse

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

    @reader.file = ftxt

    @reader = Reader.new( File.new("test/the_turtle-nash.txt") )
    @reader = ProvisionalRank.new(@reader)
    @reader = ProvisionalStress.new(@reader)
    @reader = DemoteStress.new(@reader)
    @reader = PromoteStress.new(@reader)
    @reader = GuessMeter.new(@reader)
    @reader = HtmlDecorator.new(@reader)
    
    output = @reader.parse

    fhtml = IO.readlines("test/the_turtle-nash.html")
    
    assert( output.to_s == fhtml.to_s )
  end
end
