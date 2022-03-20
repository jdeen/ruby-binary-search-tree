RSpec.describe BinarySearchTree::Tree do
  let(:tree) { described_class.new }

  context "#insert" do
    it "generates the tree" do
      values = [50, 70, 30, 40, 20]
      values.each { |value| tree.insert(value) }

      root = tree.root

      expect(root).to_not be nil
      expect(root.value).to eq 50
      expect(root.left.value).to eq 30
      expect(root.right.value).to eq 70

      # node with value three
      node_thirty = root.left
      expect(node_thirty.left.value).to eq 20
      expect(node_thirty.right.value).to eq 40
      expect(node_thirty.left.children?).to be_falsy
      expect(node_thirty.right.children?).to be_falsy

      expect(root.right.children?).to be_falsy

      search_result = tree.search(40)
      expect(search_result).to eq(node_thirty.right)
    end
  end

  context "#min" do
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
      [40, 25, 12, 5, 30, 28, 35, 50].each  { |value| tree.insert(value) }
      expect(tree.min.value).to eq(5)
    end
  end

  context "#inorder_successor" do
    it "finds the inode successor" do
      [40, 25, 12, 5, 30, 28, 35, 50].each  { |value| tree.insert(value) }

      node_25 = tree.search(25)
      expect(node_25.value).to eq(25)
      expect(tree.inorder_successor(node_25).value).to eq 28
    end
  end

  context "#delete" do
    before(:each) do
      [40, 25, 12, 5, 30, 28, 35, 50, 70].each  { |value| tree.insert(value) }
    end

    it "deletes a node with no children" do
      expect(tree.root.left.right.children.count).to eq 2

      node = tree.delete(35)
      expect(node.value).to eq(35)
      expect(tree.root.left.right.right).to be_nil
      expect(tree.root.left.right.children.count).to eq 1
    end

    it "deletes a node with a left child" do
      node = tree.delete(12)
      expect(node.value).to eq 12
      expect(tree.root.left.left.value).to eq 5
    end

    it "deletes a node with right child" do
      node = tree.delete(50)
      expect(node.value).to eq 50
      expect(tree.root.children.count).to eq 2
      expect(tree.root.right.value).to eq 70
    end

    it "deletes a node with 2 children" do
      node = tree.delete(25)
      expect(node.value).to eq 25
      expect(tree.root.left.value).to eq 28
      expect(tree.root.left.right.value).to eq 30
      expect(tree.root.left.right.children.count).to eq 1
      expect(tree.root.left.right.right.value).to eq 35
    end
  end
end

