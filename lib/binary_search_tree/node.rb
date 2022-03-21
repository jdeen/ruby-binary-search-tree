# frozen_string_literal: true

module BinarySearchTree
  # Node of a Binary Search Tree.
  #
  # @author Ziyan Junaideen
  class Node
    # The value of the node.
    # @return [Numeric] the node value
    attr_accessor :value

    # The parent node of the current node
    # @return [BinarySearchTree::Node] the parent node
    attr_accessor :parent

    # The left child node of the current node. This should always be less than the current node.
    # @return [BinarySearchTree::Node] the left child node
    attr_reader :left

    # The right child node of the current node. The right child will be larger the current node in value.
    # @return [BinarySearchTree::Node] the right child node
    attr_reader :right

    # Initialize tree node with value and optional parent node
    # @param value [Numeric] the value of the node
    # @param parent [BinarySearchTree::Node] the parent node
    def initialize(value, parent = nil)
      @value = value
      @parent = parent
    end

    # Check if the current node has any children
    # @return [Boolean] true if the node has any children
    def children?
      children.any?
    end

    # Provides a list of children
    # @return [Array<BinarySearchTree::Node>] an array of children nodes
    def children
      [left, right].compact
    end

    # Finds the child and replaces it with the provided node. This will also set the parent node of the given node.
    # @param child [BinarySearchTree::Node] the child node
    # @param node [BinarySearchTree::Node] the replacement node
    # @return [void]
    def replace_child(child, node = nil)
      @left = node    if left == child
      @right = node   if right == child

      node.parent = self if node
    end

    # Copies children from a provided node
    # @param node [BinarySearchTree::Node] the node to copy children from
    # @return [void]
    def copy_children(node)
      @left = node.left
      @right = node.right
    end

    # Set the left child node
    # @param node [BinarySearchTree::Node] the left child node
    def left=(node)
      node.parent = self
      @left = node
    end

    # Set the right child node
    # @param node [BinarySearchTree::Node] the right child node
    def right=(node)
      node.parent = self
      @right = node
    end
  end
end
