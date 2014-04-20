class PriorityQueue
  def initialize(count_hash)
    @queue = Array.new
    count_hash.each do |key, value|
      self.insert(Node.new(key, value))
    end
  end

  def insert(new_object)
    @queue.each_index do |index|
      if(new_object.frequency < @queue[index].frequency)
        @queue.insert(index, new_object)
        return self
      end
    end
    @queue.push(new_object)
    return self
  end

  def empty?
    @queue.length == 0
  end

  def pop
    @queue.shift
  end

  def to_s
    @queue.map do |node|
      "#{node.char}: #{node.frequency}"
    end.join("\n")
  end
end
