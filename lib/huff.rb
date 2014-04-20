require 'huff/node'
require 'huff/priority_queue'
require 'huff/tree'

class Huff
  def initialize(name)
    @file = File.new(name, 'r')
    @text = @file.read
    @compression_hash = build_compression_hash
  end

  def self.huff(name)
    compressor = Huff.new(name)
    compressed_file = compressor.compress
  rescue Errno::ENOENT => e
    puts 'File not found.'
  end

  def self.unhuff(compressed)
    puts 'decompressing....'
  end

  def compress
    puts 'compressing....'
    puts @text
    compressed_text = @text.split('').map do |c|
      @compression_hash[c]
    end.join('')
    puts compressed_text
  end

  private

  def build_compression_hash
    char_count_hash = count_chars(@text)
    char_priority_queue = PriorityQueue.new(char_count_hash)
    Tree.new(char_priority_queue).compression_hash
  end

  def count_chars(text)
    char_count_hash = Hash.new(0)
    text.each_char do |c|
      char_count_hash[c] += 1
    end
    char_count_hash
  end

  def print_hash(h)
    h.each do |key, value|
      puts "#{key}: #{value}"
    end
  end
end
