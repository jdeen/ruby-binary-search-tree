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
      # The node not found
      return if node.nil?

      # Recursion to find the node
      return search(node.left, value) if value < node.value
      return search(node.right, value) if value > node.value

      node
    end

    def min(node = root)
      return node if node.left.nil?

      min(node.left)
    end

    def inorder_successor(node)
      min(node.right)
    end

    def delete(node = root, value)
      # Find the node to be deleted
      delete_node = search(node, value)
      return unless node

      if delete_node.children.count == 2
        successor = inorder_successor(delete_node)

        # Detach the successor and assign its right side to parent
        successor.parent.replace_child(successor, successor.right)

        # Swap the successor with the current node
        successor.copy_children(delete_node)
        delete_node.parent.replace_child(delete_node, successor)

        delete_node
      else
        child = delete_node.children.first
        child.parent = delete_node.parent if child
        delete_node.parent.replace_child(delete_node, child)

        delete_node
      end
    end
  end
end
