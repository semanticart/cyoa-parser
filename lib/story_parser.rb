require 'parslet'

class StoryParser < Parslet::Parser
  rule(:space) { match('\s').repeat }
  rule(:newline) { match('\n') }

  rule(:heading) { match('# ') >> space.maybe >> (match['\n{'].absent? >> any).repeat.as(:heading) >> id.maybe }
  rule(:id)      { str('{#') >> (str('}').absent? >> any).repeat.as(:id) >> str('}') }
  rule(:content) { ((id | heading).absent? >> any).repeat }
  rule(:section) { (heading >> space.maybe >> content.as(:content) >> space.maybe).as(:section) }

  rule(:tile_block) { (str('%') >> (newline.absent? >> any).repeat >> newline).repeat }

  rule(:story) { space.maybe >> tile_block.maybe >> space.maybe >> section.repeat }

  root(:story)
end

