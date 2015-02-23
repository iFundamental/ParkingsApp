class Article
	
	 def initialize(title, body, author=nil)
    	@title=title
    	@body=body
    	@author=author
    	@created_at=Time.now
    	@likes=0
    	@dislikes=0
  	end
  	def title
      @title
	end
  	def body
  		@body
  	end
  	def author
  		@author
  	end
  	def created_at
  		@created_at
  	end
  	def likes
  		@likes
  	end
  	def likes=(likes)
      @likes = likes
  	end
  	def dislikes
  		@dislikes
  	end
  	def dislikes=(dislikes)
      @dislikes = dislikes
  	end
end