class Article
  attr_accessor :likes, :dislikes
  attr_reader :title, :body, :author, :created_at
  def initialize(title, body, author=nil)
    @title=title
    @body=body
    @author=author
    @created_at=Time.now
    @likes=0
    @dislikes=0
  end
  def like!
  	  @likes += 1
  end
  def dislike!
  	@dislikes +=1
  end
  def points
  	@likes - @dislikes
  end
  def votes
  	@likes + @dislikes
  end
  def length
  	@body.length
  end
  def long_lines
  	@body.lines.to_a.select{|line| line.length>80}
  end
  def truncate(limit)
    if @body.length <= limit
  	  @body
    else
  	  @body[0,limit-3] << "..."
   end
  end
  def contain?(search_string)
    if search_string.is_a?(String)
  	  return @body.include? search_string
  	elsif search_string.respond_to?(:match)
  	  return search_string.match(@body).length >0			
  	else
  	 return false
    end
  end
end