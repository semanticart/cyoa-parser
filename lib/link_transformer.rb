require 'parslet'

class LinkTransformer < Parslet::Transform
  rule(id: simple(:id)) { id.to_s }
end

