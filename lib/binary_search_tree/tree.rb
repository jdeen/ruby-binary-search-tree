module BinarySearchTree
  class Tree
    attr_accessor :root

    def insert(node = root, value)
      if node.nil?
        new_node = Node.new(value)
      elsif value < node.value
        new_node = insert(node.left, value)
        node.left = new_node unless node.left
      else
        new_node = insert(node.right, value)
        node.right = new_node unless node.right
      end

      @root = new_node unless root

      new_node
    end

    def search(node = root, value)
      return if node.nil?
      
      if node.value == value
        node
      elsif value < node.value
        search(node.left, value)
      else
        search(node.right, value)
      end
    end

    def min(node = root)
      return node if node.left.nil?
      min(node.left)
    end

    def inorder_successor(node)
      min(node.right)
    end


    def delete(node = root, value)
      return if node.nil?

      return delete(node.left, value)  if value < node.value
      return delete(node.right, value) if value > node.value

      # The node value matches the value provided
      # These will be the break conditions that handle deletions

      if node.children.count == 2
        successor =  inorder_successor(node)

        # Detach the successor and assign its right side to parent
        successor.parent.replace_child(successor, successor.right)

        # Swap the successor with the current node
        successor.copy_children(node)
        node.parent.replace_child(node, successor)

        node
      else
        child = node.children.first
        child.parent = node.parent if child
        node.parent.replace_child(node, child)
        
        node
      end
    end
  end
end
