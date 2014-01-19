require 'parslet'

class LinkParser < Parslet::Parser
  rule(:link_text) { str("[") >> (str(']').absent? >> any).repeat >> str(']') }
  rule(:link_href) { str('(#') >> (str(')').absent? >> any).repeat.as(:id) >> str(')') }
  rule(:link)      { link_text >> link_href }
  rule(:non_link)  { (link.absent? >> any).repeat }
  rule(:content)   { (non_link >> link >> non_link).repeat }

  root(:content)
end
