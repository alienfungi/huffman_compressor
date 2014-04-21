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
    compressor.compress
  rescue Errno::ENOENT => e
    puts 'File not found.'
  end

  def compress
    puts 'compressing....'
    compressed_text = @text.split('').map do |c|
      @compression_hash[c]
    end.join('')
    write_to_file(compressed_text)
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

  def binary_compression_hash
    @compression_hash.map { |key, value| "#{key}#{value}" }.join('&#')
  end

  def write_to_file(binary_string)
    padding = 15 - binary_string.length % 8
    padding = '0' * padding + '1'
    part_3 = [padding + binary_string].pack('B*')
    part_2 = binary_compression_hash
    part_1 = [part_2.length].pack('I')
    File.open('output.huff', 'wb') do |output|
      output.write part_1
      output.write part_2
      output.write part_3
    end
  end
end
