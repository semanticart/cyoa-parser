require_relative "spec_helper"

describe Story do
  it "can generate all branches" do
    story = Story.new(File.open("examples/smell-ya-later.md"))
    expected = [
      ["intro", "investigate", "help"],
      ["intro", "investigate", "rescue", "wake-up"],
      ["intro", "investigate", "grounded"],
      ["intro", "grounded"]
    ]
    assert_equal expected, story.branches
  end

  it "can find unreachable pages" do
    story = Story.new(File.open("examples/example_story.md"))
    assert_equal ['some-unreachable-page'], story.unreachable
  end
end
