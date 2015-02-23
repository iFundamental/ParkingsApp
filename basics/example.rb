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
    self.likes += 1
  end

  def dislike!
    self.dislikes +=1
  end

  def points
    likes - dislikes
  end

  def votes
    likes + dislikes
  end

  def length
    body.length
  end

  def long_lines
    body.lines.to_a.select{|line| line.length>80}
  end

  def truncate(limit)
    if body.length <= limit
      body
    else
      body[0,limit-3] << "..."
   end
  end

  def contain?(search_string)
    if search_string.is_a?(String)
      return  !! body[search_string]
    elsif search_string.respond_to?(:match)
      return search_string.match(body).length >0     
    else
     return false
    end
  end
end

class ArticlesFileSystem
  def initialize(dir_name)
    @dir_name = dir_name
  end 

  def save(articles)
    articles.each do |article|
      filename = article.title.gsub(" ", "_").downcase << ".article"
      filebody = article.author << "||" << article.likes.to_s << "||" << article.dislikes.to_s << "||" << article.body
      File.open("#{@dir_name}/#{filename}", 'w+') do |f|  
       f.write filebody
      end  
    end 
  end

  def load
    articles= Array.new
    Dir.chdir("#{@dir_name}") 
    Dir.glob("*.article").each do |filename|
      File.open(filename, "r") do |file|
        title=File.basename(filename, ".article").gsub("_", " ").capitalize
        data=File.read(filename).split("||")
        article = Article.new(title, data[3], data[0])
        article.likes=data[1].to_i
        article.dislikes=data[2].to_i
        articles << article     
      end      
    end
    articles
  end
end

class WebPage
  attr_reader :articles
  def initialize(dir_name="/")
    @dir_name=dir_name
    @fs=ArticlesFileSystem.new(@dir_name)
    self.load
  end

  def load
      @articles=@fs.load
  end

  def save
    @fs.save(@articles)
  end

  def new_article(title, body, author)
    article=Article.new(title, body, author)
    @articles <<article
  end
end

