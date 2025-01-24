require_relative "node"

# Build a Tree class which accepts an array when initialized
# root attribute, which uses the return value of #build_tree
# write a #build_tree method which takes an array of data and turns it
# into a balanced binary tree full of Node objects appropriately placed
# Don't forget to sort and remove duplicates
# The #build_tree method should return the level-0 root node
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
      return root
    else
    # recursively
    # start / mid / end of array
    root = nil
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
    if root == nil
      root = new_node
    end
    end
    
  end
end

test_array = [0, 1, 2, 3, 4, 5, 6, 7]
t = Tree.new(test_array)
t.pretty_print
puts t.root
puts t.root.left.data
puts t.root.right.data

