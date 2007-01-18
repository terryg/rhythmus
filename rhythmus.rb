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

class Rhythmus
  attr_accessor :txtfile
  attr_accessor :reader

  def initialize(txt, dict)
    dictionary = Dictionary.instance
    dictionary.load(dict)

    @txtfile = txt

    @reader = Reader.new
  end

  def to_html(io = $defout)
    dictionary = Dictionary.instance

    ftxt = File.new(@txtfile)
    
    @reader.file = ftxt

    @reader = Reader.new( File.new(@txtfile) )
    @reader = ProvisionalRank.new(@reader)
    @reader = ProvisionalStress.new(@reader)
    @reader = DemoteStress.new(@reader)
    @reader = PromoteStress.new(@reader)
    @reader = GuessMeter.new(@reader)
    @reader = HtmlDecorator.new(@reader)
   
    io << @reader.parse
  end
end

if $0 == __FILE__
  file1 = ARGV.shift
  file2 = ARGV.shift
  file3 = ARGV.shift

  t = Timer.new
  
  if File.exist?(file1) 
    rhythmus = Rhythmus.new(file1, file2)

    io = File.new(file3, File::CREAT|File::TRUNC|File::RDWR, 0644)
 
    rhythmus.to_html(io)

    io = File.new(file2, File::CREAT|File::TRUNC|File::RDWR, 0644)

    dictionary = Dictionary.instance
    dictionary.to_dict(io)
  end
  
  printf "Total time: " + t.elapsed + "\n"
  
end
