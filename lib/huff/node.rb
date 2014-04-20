class Node
  attr_reader :char, :frequency, :left, :right

  def initialize(char, frequency, left=nil, right=nil)
    @char = char
    @frequency = frequency
    @left = left
    @right = right
  end
end
