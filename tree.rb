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
    # sort array / eliminate duplicates
    array = array.uniq.sort
    
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

  # Write an #insert and #delete method which accepts a value to insert / delete
  # You'll have to deal with several cases for delete, such as when a node has children or not
  # Traverse the tree, do not modify the input array
  # Initialize current node with root node
  # left if key is less than or equal to the current node value
  # right if greater than current node value
  # repeat until leaf node reached
  # attach new key as left or right based on comparison
  def insert(value)
    new_node = Node.new(value)
    cursor = root
    
    # empty tree?
    if @root == nil
      @root = new_node
    end
    while cursor != nil
      if value > cursor.data
        if cursor.right == nil
          cursor.right = new_node
          return new_node
        else  
          cursor = cursor.right
        end
      elsif value < cursor.data
        if cursor.left == nil
          cursor.left = new_node
        else
          cursor = cursor.left
        end
      else
        return
      end
    end
  end

  def delete(value)
    # empty tree
    if @root.nil?
      return nil
    end

    cursor = root
    ## tree traversal
    while cursor != nil
      if value < cursor.data
        cursor_parent = cursor
        cursor = cursor.left
      elsif value > cursor.data
        cursor_parent = cursor
        cursor = cursor.right
      elsif value == cursor.data
        # found the value we are looking for
        # target node has no children
        if cursor.left == nil && cursor.right == nil
          if cursor.data < cursor_parent.data
            cursor_parent.left = nil
            return cursor
          else
            cursor_parent.right = nil
            return cursor
          end
        # target node has 1 child
        elsif cursor.left != nil && cursor.right == nil || cursor.left == nil && cursor.right != nil
          # child is left
          if cursor.left != nil
            if cursor.data < cursor_parent.data
              cursor_parent.left = cursor.left
            else
              cursor_parent.right = cursor.left
            end
          # child is right
          else 
            if cursor.data < cursor_parent.data
              cursor_parent.left = cursor.right
            else
              cursor_parent.right = cursor.right
            end
          end
      # target node has 2 children
      # inorder successor will be the smallest node that is larger than node
      # this means: 1 step right (needs to be larger), and then traverse the tree until we find the smallest of the largest
        else
          # 1 step right
          cursor_explorer_smallest_parent = cursor
          cursor_explorer_smallest = cursor.right
          while cursor_explorer_smallest.left != nil
            cursor_explorer_smallest_parent = cursor_explorer_smallest
            cursor_explorer_smallest = cursor_explorer_smallest.left
          end
          # at the end of this loop, cursor_explorer_smallest should be pointing to the smallest node
          # smallest should be the new value of the target node, 
          # and we should remove the pointer from the parent of smallest
          # smallest has no children or 1 right children (no other options, it's the smallest so no left children possible)
          # no right child
          if cursor_explorer_smallest.right == nil
            cursor.data = cursor_explorer_smallest.data
            cursor_explorer_smallest_parent.right = nil # always rigth, we are as far left as possible (smallest)
          # 1 right child
          else
            cursor.data = cursor_explorer_smallest.data
            cursor_explorer_smallest_parent.right = cursor_explorer_smallest.right
          end
        end
      end
    end
    ## tree traversal completed
    return cursor
  end

  # find method accepts a value and returns the node with the given value
  def find(value)

    if root.nil?
      return nil
    end

    cursor = root
    while cursor != nil
      if value < cursor.data
        cursor = cursor.left
      elsif value > cursor.data
        cursor = cursor.right
      elsif value == cursor.data
        return cursor
      end
    end
    return nil
  end

end

test_array2 = [0, 5, 10, 15, 20, 25, 30, 35, 40]
# t1 = Tree.new(test_array1)
# t.pretty_print
# p t.root

t2 = Tree.new(test_array2)
puts "\n\n"

# t2.insert(90)
# t2.insert(1)
# t2.insert(4)
# t2.insert(751)
# t2.insert(752)
# t2.insert(755)
# t2.insert(50000)
# t2.insert(2)
# t2.delete(5)
# t2.delete(9999)
p t2.find(30)
p t2.find(48392)