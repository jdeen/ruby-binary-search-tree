module BinarySearchTree
  # The basic BinarySearchTree
  #
  # @author Ziyan Junaideen
  class Tree
    # The root note of the BST Tree
    # @return [BinarySearchTree::Node] the root node
    attr_accessor :root

    # Inserts a value to the Binary Search Tree (or sub-tree denoted by the `node` attribute).
    # @param node [BinarySearchTree::Node] the tree/sub-tree root node
    # @param value [Numeric] the value to be inserted to the tree
    # @return [BinarySearchTree::Node] the BST Node that was inserted
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

    # Searches the BST Tree (or a sub-tree denoted by `node`) for a given value and return its node.
    # @param node [BinarySearchTree::Node] the root node of the tree/sub-tree
    # @param value [Numeric] the value to search
    # @return [BinarySearchTree::Node, nil] the node corresponding to the given value
    def search(node = root, value)
      # The node not found
      return if node.nil?

      # Recursion to find the node
      return search(node.left, value) if value < node.value
      return search(node.right, value) if value > node.value

      node
    end

    # Provide the node corresponding to the min value stored in the BST tree (or sub-tree)
    # @param node [BinarySearchTree::Node] the root node of the tree/sub-tree to find the min value of
    # @return [BinarySearchTree::Node] the node with the min value
    def min(node = root)
      return node if node.left.nil?

      min(node.left)
    end

    # Provide the inorder successor of the node.
    # @note expected to be used with #delete
    # @return [BinarySearchTree<Node>] the inorder successor for the provided node
    def inorder_successor(node)
      min(node.right)
    end

    # Deletes the node from the tree and update references accordingly.
    # @return [BinarySearchTree<Node>] the deleted node
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
