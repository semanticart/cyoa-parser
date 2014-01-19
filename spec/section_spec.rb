require_relative "spec_helper"

describe Section do
  it "can dasherize the title to form an id if none is provided" do
    section = Section.new(id: nil, heading: "Something isn't right here.")

    assert_equal "something-isnt-right-here", section.id
  end

  it "can find links" do
    section = Section.new(id: "something", content: "Some content here.\n\nSome more conent with [a link](#phone).\n\n Now another [link](#another).")

    assert_equal ["phone", "another"], section.links
  end
end

