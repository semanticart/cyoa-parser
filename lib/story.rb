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

  class BranchCruncher
    attr_reader :sections

    def initialize(sections)
      @sections = sections
      @branches = []
    end

    def traverse
      follow(sections.first.id)
      @branches
    end

    def follow(id, seen = [])
      seen << id
      current = sections.detect{|section| section.id == id}

      links_to_follow = current.links.reject{|link_id| seen.include?(link_id)}

      if links_to_follow.size == 0
        @branches << seen
      else
        links_to_follow.map do |link_id|
          follow(link_id, seen.dup)
        end
      end
    end
  end
end
