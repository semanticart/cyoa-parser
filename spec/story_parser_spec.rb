require_relative 'spec_helper'

describe StoryParser do
  def parse(input)
    StoryParser.new.parse(input)
  end

  it "can parse a single section without a custom id" do
    parsed = parse(File.read("examples/single-section-with-no-custom-id.md")).first[:section]

    assert_equal '', parsed[:id].to_s
    assert_equal "Something isn't right here.", parsed[:heading].to_s
    assert_equal "You hear a phone ringing.\n\n- [pick up phone](#phone)\n- [do not answer](#ignore-phone)\n- [set yourself on fire](#fire)\n",
      parsed[:content].to_s
  end

  it "can parse a single section with a custom id" do
    parsed = parse(File.read("examples/single-section-with-a-custom-id.md")).first[:section]

    assert_equal "intro", parsed[:id].to_s
    assert_equal "Something isn't right here. ", parsed[:heading].to_s
    assert_equal "You hear a phone ringing.\n\n- [pick up phone](#phone)\n- [do not answer](#ignore-phone)\n- [set yourself on fire](#fire)\n",
      parsed[:content].to_s
  end

  it "can parse an entire story" do
    parsed = parse(File.read("examples/example_story.md"))

    first, second, third = parsed.map{|s| s[:section]}

    assert_equal "intro", first[:id].to_s
    assert_equal "Something isn't right here. ", first[:heading].to_s
    assert_equal "You hear a phone ringing.\n\n- [pick up phone](#phone)\n- [do not answer](#ignore-phone)\n- [set yourself on fire](#fire)\n\n",
      first[:content].to_s

    assert_equal "phone", second[:id].to_s
    assert_equal "You pick up the phone... ", second[:heading].to_s
    assert_equal "It is your grandmother. You die.\n\n- [start over](#intro)\n\n",
      second[:content].to_s

    assert_equal "ignore-phone", third[:id].to_s
    assert_equal "You ignore the phone... ", third[:heading].to_s
    assert_equal "It was your grandmother. You die.\n\n- [start over](#intro)\n\n",
      third[:content].to_s
  end
end

