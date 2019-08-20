require_relative 'branch_cruncher'

class Story
  attr_reader :sections

  def initialize(file)
    @sections = parse_file(file)
  end

  def branches
    @_branches ||= BranchCruncher.new(@sections).traverse
  end

  def reachable
    branches.flatten.uniq
  end

  def unreachable
    @sections.map(&:id) - reachable
  end

  def broken
    @sections.map(&:links).flatten.uniq.compact - @sections.map(&:id)
  end

  def split!(path)
    branches.each do |branch|
      File.open(path + branch.join('-') + '.md', 'w') do |f|
        branch.each do |id|
          section = sections.detect{|s| s.id == id}
          f.puts "# #{section.heading} {##{section.id}}\n"
          f.puts section.content
          f.puts "\n\n"
        end
      end
    end
  end

  private

  def parse_file(file)
    SectionTransformer.new.apply(StoryParser.new.parse(file.read))
  end
end
