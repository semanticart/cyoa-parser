require_relative 'spec_helper'

describe SectionTransformer do
  it "creates section objects" do
    input = [{section: {
      heading: "Welcome",
      content: "\nHello there!\n\nHow are you?!?!\n\n\n\n",
      id: "welcome"
    }}]

    expected = Section.new(
      heading: "Welcome",
      content: "Hello there!\n\nHow are you?!?!",
      id: "welcome"
    )

    transformed = SectionTransformer.new.apply(input).first
    assert_equal expected.content, transformed.content
    assert_equal expected.heading, transformed.heading
    assert_equal expected.id,      transformed.id
  end
end

