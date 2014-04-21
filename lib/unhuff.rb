require 'huff/node'
require 'huff/tree'

class Unhuff
  def initialize(name)
    @name = name
    data = File.open(@name, 'rb') {|io| io.read}

    hash_size = data.byteslice(0, 4).unpack('I').first
    @tree = Tree.new(compression_hash(data.byteslice(4, hash_size)))

    data_start = 4 + hash_size
    data_size = data.length - data_start
    @data = data.byteslice(data_start, data_size).unpack('B*').first
    remove_padding
  end

  def self.unhuff(name)
    decompressor = Unhuff.new(name)
    decompressor.decompress
  rescue Errno::ENOENT => e
    puts 'File not found.'
  end

  def decompress
    puts 'decompressing....'
    current = @tree.root
    decompressed = []
    @data.each_char do |bit|
      if(current.left.nil? && current.right.nil?)
        decompressed.push(current.char)
        current = @tree.root
      end
      current = bit == '0' ? current.left : current.right
    end
    write_to_file(decompressed.push(current.char).join)
  end

  private

  def compression_hash(text_compression_hash)
    text_compression_hash.split('&#').each_with_object({}) do |string, hash|
      hash[string.slice!(0)] = string
    end
  end

  def remove_padding
    (0..15).each do |index|
      if(@data[index] == '1')
        @data.slice!(0, index + 1)
        return
      end
    end
  end

  def write_to_file(string)
    File.open('output.unhuff', 'w') do |output|
      output.write(string)
    end
  end
end
