require_relative "node"

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
 

  def build_tree(array)
    # base case is array.length == 1??? or array.length == 0???
    if array.length == 0
      return
    else
    # recursively
    # start / mid / end of array
    start_of_array = 0
    end_of_array = array.length - 1
    mid_of_array = (start_of_array + end_of_array) / 2
    # process array
    # mid of array is the root node
    # left is left child of node
    # end is right child of node
    left_subarray = array[0...mid_of_array]
    right_subarray = array[mid_of_array + 1..end_of_array]

    new_node = Node.new(array[mid_of_array], build_tree(left_subarray), build_tree(right_subarray))

    end
    
  end
end

test_array = [0, 1, 2, 3, 4, 5, 6, 7]
t = Tree.new(test_array)
t.pretty_print

