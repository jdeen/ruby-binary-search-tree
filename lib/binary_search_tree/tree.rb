# frozen_string_literal: true

module BinarySearchTree
  # The basic BinarySearchTree
  #
  # @author Ziyan Junaideen
  class Tree
    # The root note of the BST Tree
    # @return [BinarySearchTree::Node] the root node
    attr_accessor :root

    # Inserts a value to the Binary Search Tree (or sub-tree denoted by the `node` attribute).
    # @param value [Numeric] the value to be inserted to the tree
    # @param node [BinarySearchTree::Node] the tree/sub-tree root node
    # @return [BinarySearchTree::Node] the BST Node that was inserted
    def insert(value, node = root)
      if node.nil?
        new_node = Node.new(value)
      elsif value < node.value
        new_node = insert(value, node.left)
        node.left = new_node unless node.left
      else
        new_node = insert(value, node.right)
        node.right = new_node unless node.right
      end

      @root = new_node unless root

      new_node
    end

    # Searches the BST Tree (or a sub-tree denoted by `node`) for a given value and return its node.
    # @param value [Numeric] the value to search
    # @param node [BinarySearchTree::Node] the root node of the tree/sub-tree
    # @return [BinarySearchTree::Node, nil] the node corresponding to the given value
    def search(value, node = root)
      # The node not found
      return if node.nil?

      # Recursion to find the node
      return search(value, node.left) if value < node.value
      return search(value, node.right) if value > node.value

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

    # rubocop:disable Metrics/AbcSize
    # Deletes the node from the tree and update references accordingly.
    # @param value [Numeric] the value of the node to be deleted
    # @param node [BinarySearchTree::Node] the root note to start searching
    # @return [BinarySearchTree<Node>] the deleted node
    def delete(value, node = root)
      # Find the node to be deleted
      delete_node = search(value, node)
      return unless node

      if delete_node.children.count == 2
        successor = inorder_successor(delete_node)

        # Detach the successor and assign its right side to parent
        successor.parent.replace_child(successor, successor.right)

        # Swap the successor with the current node
        successor.copy_children(delete_node)
        delete_node.parent.replace_child(delete_node, successor)
      else
        child = delete_node.children.first
        child.parent = delete_node.parent if child
        delete_node.parent.replace_child(delete_node, child)
      end

      delete_node
    end
    # rubocop:enable Metrics/AbcSize
  end
end
