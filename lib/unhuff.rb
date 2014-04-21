require 'huff/node'

class Unhuff
  def initialize(name)
    @name = name
    data = File.open(@name, 'rb') {|io| io.read}

    hash_size = data.byteslice(0, 4).unpack('I').first
    @root = build_tree(compression_hash(data.byteslice(4, hash_size)))

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
    current = @root
    decompressed = []
    @data.each_char do |bit|
      if(current.left.nil? && current.right.nil?)
        decompressed.push(current.char)
        current = @root
      end
      current = bit == '0' ? current.left : current.right
    end
    write_to_file(decompressed.push(current.char).join)
  end

  private

  def build_tree(hash)
    root = Node.new(nil, nil)
    hash.each do |char, bit_string|
      current = root
      bit_string.each_char do |bit|
        if(bit == '0')
          current.left ||= Node.new(char, nil)
          current = current.left
        else
          current.right ||= Node.new(char, nil)
          current = current.right
        end
      end
    end
    root
  end

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
