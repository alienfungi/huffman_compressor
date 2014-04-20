class Tree
  attr_reader :root, :compression_hash

  def initialize(priority_queue)
    @compression_hash = {}
    while(!priority_queue.empty?) do
      temp_1 = priority_queue.pop
      if(priority_queue.empty?)
        @root = temp_1
      else
        temp_2 = priority_queue.pop
        temp_3 = Node.new(nil, temp_1.frequency + temp_2.frequency, temp_1, temp_2)
        priority_queue.insert(temp_3)
      end
    end
    map_bit_values(root, '')
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
end
