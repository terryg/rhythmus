#!/usr/bin/env ruby

$:.unshift('lib')

require 'dictionary'
require 'reader'
require 'provisional_rank'
require 'provisional_stress'
require 'demote_stress'
require 'promote_stress'
require 'guess_meter'
require 'html_decorator'
require 'timer'

require 'optparse'
require 'ostruct'

class Rhythmus
  VERSION = '0.5'

  attr_reader :options
  
  def initialize(argv, stdin)
    @arguments = argv
    @stdin = stdin
  
    @options = OpenStruct.new
    @options.infile = nil
    @options.outfile = "output.html"
    @options.dictionary = "rhythmus.dict"
  end

  def run
    if parsed_options? and arguments_valid?
      dictionary = Dictionary.instance
      dictionary.load(@options.dictionary)
  
      io = File.new(@options.outfile, File::CREAT|File::TRUNC|File::RDWR, 0644)
 
      to_html(io)

      io = File.new(@options.dictionary, File::CREAT|File::TRUNC|File::RDWR, 0644)

      dictionary = Dictionary.instance
      dictionary.to_dict(io)
    else
      puts 'Usage: rhytmus.rb [options] file-to-parse'
      puts '         -d FILE, --dictionary FILE    the rhythmus dictionary to use for' 
      puts '                                       syllable information'
      puts '                                       default: rhythmus.rb'
      puts '         -o FILE, --outfile FILE       the output file to generate with '
      puts '                                       the scanned poem'
      puts '                                       default: output.html'
    end
  end
  
  protected
  
  def parsed_options?    
    opts = OptionParser.new do |opts|
      opts.on("-d", "--dictionary [DICT]", String, "The dictionary file to use for parsing.") do |dict|
        @options.dictionary = dict
      end
    
      opts.on("-o", "--outfile [OUT]", String, "The output HTML file to record the results.") do |outfile|
        @options.outfile = outfile
      end
    end
    
    @options.infile = @arguments.last

    opts.parse!(@arguments)
  end
  
  def arguments_valid?
    if File.exists?(@options.infile) and File.exists?(@options.dictionary)
      true
    else
      false
    end
  end
  
  def to_html(io = $defout)
    ftxt = File.new(@options.infile)
    
    reader = Reader.new( ftxt )
    reader = ProvisionalRank.new(reader)
    reader = ProvisionalStress.new(reader)
    reader = DemoteStress.new(reader)
    reader = PromoteStress.new(reader)
    reader = GuessMeter.new(reader)
    reader = HtmlDecorator.new(reader)
   
    io << reader.parse
  end
end

# Create and run the application
app = Rhythmus.new(ARGV, STDIN)
app.run

