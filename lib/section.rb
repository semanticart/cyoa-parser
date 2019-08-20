class Section
  attr_reader :id, :content, :heading, :links
  def initialize(hash)
    @content = hash[:content]
    @heading = hash[:heading]
    @id      = id_for(hash[:id])
    @links   = find_links || []
  end

  private

  def find_links
    return unless content && !content.empty?

    begin
      ::LinkTransformer.new.apply(::LinkParser.new.parse(content))
    rescue Parslet::ParseFailed
    end
  end

  def id_for(input)
    return input if input

    heading.downcase.gsub(/[^a-z ]+/, '').gsub(/\s+/, '-')
  end
end

