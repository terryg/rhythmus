#!/usr/bin/env ruby

$:.unshift('lib')

require 'dictionary'
require 'reader'

class Rhythmus
  attr_accessor :txtfile
  attr_accessor :reader

  def initialize(txt, dict)
    dictionary = Dictionary.instance
    dictionary.load(dict)

    @txtfile = txt

    @reader = Reader.new
  end

  def ask_user(word)
    print "\nEnter dictionary listing for #{word} [syl/lab/les 123]: "
    response = $stdin.gets.chomp
    entry = response.split(/ /)
    
    if 2 == entry.size
      return entry
    else 
      return nil
    end
  end

  def to_html(io = $defout)
    dictionary = Dictionary.instance

    ftxt = File.new(@txtfile)
    
    ftxt.each_line do |line|
      @reader.parse(line)
    end

    @reader.words.each do |word|
      if !dictionary.find?(word.characters)
        answer = ask_user(word.characters)
        if nil != answer
          dictionary.add(answer[0], answer[1])
        end
      end
    end

    io << @reader.to_html
  end

end

if $0 == __FILE__
  file1 = ARGV.shift
  file2 = ARGV.shift

  rhythmus = Rhythmus.new(file1, file2)

  rhythmus.to_html

  io = File.new(file2, File::CREAT|File::TRUNC|File::RDWR, 0644)

  dictionary = Dictionary.instance
  dictionary.to_dict(io)
end
