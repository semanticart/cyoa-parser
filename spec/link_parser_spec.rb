require_relative 'spec_helper'

describe LinkParser do
  def parse(input)
    LinkParser.new.parse(input)
  end

  it "can match a single link" do
    parsed = parse("[some link name](#some-href)").first

    assert_equal "some-href",
      parsed[:id]
  end

  it "can match a single link surrounded by content" do
    parsed = parse("
      hey there [some link name](#some-href)
      some content
    ").first

    assert_equal "some-href",
      parsed[:id]
  end

  it "can match a multiple links surrounded by content" do
    parsed = parse("
      hey there [some link name](#some-href)
      some content with a link [another](#new-href) and [another still](#last) ok?
    ")

    assert_equal ["some-href", "new-href", "last"],
      parsed.map{|s| s[:id].to_s}
  end
end

