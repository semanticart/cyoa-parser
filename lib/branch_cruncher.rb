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
