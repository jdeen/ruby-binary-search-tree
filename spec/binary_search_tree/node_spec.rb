# frozen_string_literal: true

RSpec.describe BinarySearchTree::Node do
  let(:node) { described_class.new(50) }

  describe "#children" do
    context "when no children" do
      it { expect(node.children.count).to eq 0 }
    end

    context "when having a single child" do
      before do
        node.left = described_class.new(25)
      end

      it { expect(node.children.count).to eq 1 }
      it { expect(node.children.first.value).to eq 25 }
    end

    context "when having a right child" do
      before do
        node.left = described_class.new(75)
      end

      it { expect(node.children.count).to eq 1 }
      it { expect(node.children.first.value).to eq 75 }
    end
  end

  describe "#children?" do
    it "returns false if no children" do
      expect(node.children?).to be_falsey
    end

    it "returns true if any children" do
      node.left = described_class.new(25)
      expect(node.children?).to be_truthy
    end
  end
end
