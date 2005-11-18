#!/usr/bin/env ruby

$:.unshift("lib")

require 'dictionary'
require 'reader'

class Rhythmus
  attr_accessor :txtfile

  def initialize(txt, dict)
    dictionary = Dictionary.instance
    dictionary.load(dict)

    @txtfile = txt
  end

  def to_html(io = $defout)
    reader = Reader.new
    
    ftxt = File.new(@txtfile)
    
    ftxt.each_line do |line|
      reader.parse(line)
    end

    io << reader.html
  end

end

if $0 == __FILE__
  file1 = ARGV.shift
  file2 = ARGV.shift

  rhythmus = Rhythmus.new(file1, file2)

  rhythmus.to_html
end
