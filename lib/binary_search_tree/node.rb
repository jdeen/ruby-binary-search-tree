module BinarySearchTree
  class Node
    attr_accessor :value
    attr_accessor :parent
    attr_reader :left
    attr_reader :right

    def initialize(value, parent = nil)
      @value = value
      @parent = parent
    end

    def children?
      children.any?
    end

    def children
      [left, right].compact
    end

    def replace_child(child, node)
      @left = node    if left == child
      @right = node   if right == child

      node.parent = self if node
    end

    def copy_children(node)
      @left = node.left
      @right = node.right
    end

    def left=(node)
      node.parent = self
      @left = node
    end

    def right=(node)
      node.parent = self
      @right = node
    end
  end
end
