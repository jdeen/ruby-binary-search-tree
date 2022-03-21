# frozen_string_literal: true

RSpec.describe BinarySearchTree::Tree do
  let(:tree) { described_class.new }

  describe "#insert" do
    context "when inserting first node" do
      before do
        tree.insert(50)
      end

      it { expect(tree.root.value).to eq 50 }
      it { expect(tree.root.parent).to be_nil }
      it { expect(tree.root.children).to be_empty }
    end

    context "when inserting 70" do
      before do
        [50, 70].each { |value| tree.insert(value) }
      end

      it { expect(tree.root.right.value).to eq 70 }
      it { expect(tree.root.right.parent.value).to eq 50 }
    end

    context "when inserting 30" do
      before do
        [50, 70, 30].each { |value| tree.insert(value) }
      end

      it { expect(tree.root.left.value).to eq 30 }
      it { expect(tree.root.left.parent.value).to eq 50 }
    end

    context "when inserting 40" do
      before do
        [50, 70, 30, 40].each { |value| tree.insert(value) }
      end

      it { expect(tree.root.left.right.value).to eq 40 }
      it { expect(tree.root.left.right.parent.value).to eq 30 }
    end

    context "when inserting 20" do
      before do
        [50, 70, 30, 40, 20].each { |value| tree.insert(value) }
      end

      it { expect(tree.root.left.left.value).to eq 20 }
      it { expect(tree.root.left.left.parent.value).to eq 30 }
    end
  end

  describe "#min" do
    let(:data) { [40, 28, 12, 5] }

    it "chooses the min from a left heavy tree" do
      data.each { |value| tree.insert(value) }
      expect(tree.min.value).to eq data.min
    end

    it "chooses min from right heavy tree" do
      data.reverse.each { |value| tree.insert(value) }
      expect(tree.min.value).to eq data.min
    end

    it "chooses min from a normal tree" do
      [40, 25, 12, 5, 30, 28, 35, 50].each { |value| tree.insert(value) }
      expect(tree.min.value).to eq(5)
    end
  end

  describe "#search" do
    before do
      [40, 25, 12, 5, 30, 28, 35, 50, 45].each { |value| tree.insert(value) }
    end

    it "Finds the node with value 28" do
      expect(tree.search(28).value).to eq(28)
    end

    it "Finds the node with value 50" do
      expect(tree.search(50).value).to eq(50)
    end
  end

  describe "#inorder_successor" do
    before do
      [40, 25, 12, 5, 30, 28, 35, 50, 45].each { |value| tree.insert(value) }
    end

    it "Inorder successor of 40 to eq 45" do
      expect(tree.inorder_successor(tree.root).value).to eq(45)
    end

    it "Inorder successor of 25 to eq 28" do
      expect(tree.inorder_successor(tree.search(25)).value).to eq(28)
    end
  end

  describe "#delete" do
    before do
      [40, 25, 12, 5, 30, 28, 35, 50, 70].each { |value| tree.insert(value) }
    end

    context "when deletion of a node without children: 35" do
      let!(:deleted_node) { tree.delete(25) }

      it "returns the node 35" do
        expect(deleted_node.value).to eq(25)
      end

      it { expect(tree.root.left.left.right).to be_nil }
      it { expect(tree.root.left.right.children.count).to eq 1 }
    end

    context "when deletion of a node with a child: 12" do
      let!(:deleted_node) { tree.delete(12) }

      it { expect(deleted_node.value).to eq(12) }
      it { expect(tree.root.left.left.value).to eq(5) }
      it { expect(tree.root.left.left.parent.value).to eq(25) }
    end

    context "when deletion of a node with a child: 50" do
      let!(:deleted_node) { tree.delete(50) }

      it { expect(deleted_node.value).to eq(50) }
      it { expect(tree.root.right.value).to eq(70) }
      it { expect(tree.root.right.parent.value).to eq(40) }
    end

    context "when deleting a node with two children: 25" do
      let!(:deleted_node) { tree.delete(25) }

      it { expect(deleted_node.value).to eq(25) }

      # Check the structure of the tree

      it { expect(tree.root.left.value).to eq 28 }
      it { expect(tree.root.left.right.value).to eq 30 }
      it { expect(tree.root.left.right.children.count).to eq 1 }
      it { expect(tree.root.left.right.right.value).to eq 35 }
    end
  end
end
