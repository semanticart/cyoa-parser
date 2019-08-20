require 'parslet'

class SectionTransformer < Parslet::Transform
  rule(section: subtree(:hash)) {
    hash[:content] = hash[:content].to_s.strip
    hash[:heading] = hash[:heading].to_s.strip

    if hash[:id].to_s.empty?
      hash.delete(:id)
    else
      hash[:id] = hash[:id].to_s
    end

    Section.new(hash)
  }
end
