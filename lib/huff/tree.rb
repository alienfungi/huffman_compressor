class Tree
  attr_reader :root, :compression_hash

  def initialize(object)
    @compression_hash = {}
    if(object.is_a?(Hash)) # decompression
      @root = hash_to_tree(object)
    else                   # compression
      @root = priority_queue_to_tree(object)
      map_bit_values(root, '')
    end
  end

  private

  def map_bit_values(current, bit_string)
    if(current.left != nil)
      map_bit_values(current.left, bit_string + '0')
    elsif(current.right == nil)
      compression_hash[current.char] = bit_string
    end
    if(current.right != nil)
      map_bit_values(current.right, bit_string + '1')
    end
  end

  def hash_to_tree(hash)
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

  def priority_queue_to_tree(priority_queue)
    while(!priority_queue.empty?) do
      temp_1 = priority_queue.pop
      if(priority_queue.empty?)
        return temp_1
      else
        temp_2 = priority_queue.pop
        temp_3 = Node.new(nil, temp_1.frequency + temp_2.frequency, temp_1, temp_2)
        priority_queue.insert(temp_3)
      end
    end
  end
end
