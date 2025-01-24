class Node
  attr_accessor :data, :left, :right

  def initialize(data, left, right)
    @data = data
    @left = left
    @right = right
  end
end