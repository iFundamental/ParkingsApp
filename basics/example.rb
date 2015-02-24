class Article
  attr_accessor :likes, :dislikes
  attr_reader :title, :body, :author, :created_at

  def initialize(title, body, author = nil)
    @title = title
    @body = body
    @author = author
    @created_at = Time.now
    @likes = 0
    @dislikes = 0
  end

  def like!
    self.likes += 1
  end

  def dislike!
    self.dislikes += 1
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
    body.lines.to_a.select { |line| line.length > 80 }
  end

  def truncate(limit)
    if body.length <= limit
      body
    else
      body[0,limit - 3] << "..."
   end
  end

  def contain?(search_string)
    if search_string.is_a?(String)
      return  !! body[search_string]
    elsif search_string.respond_to?(:match)
      return search_string.match(body).nil? != true  
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
      filename = article.title.gsub(' ', '_').downcase << '.article'
      filebody = article.author + '||' + article.likes.to_s + '||' + article.dislikes.to_s + '||' + article.body
      File.open("#{@dir_name}/#{filename}", 'w+') do |f|  
        f.write filebody
      end
    end
  end

  def load
    articles = []
    Dir.chdir("#{@dir_name}") 
    Dir.glob('*.article').each do |filename|
      title = File.basename(filename, '.article').gsub('_', ' ').capitalize
      data = File.read(filename).split('||')
      article = Article.new(title, data[3], data[0])
      article.likes = data[1].to_i
      article.dislikes = data[2].to_i
      articles << article
    end
    articles
  end
end

class WebPage

  class NoArticlesFound < StandardError
  end

  attr_reader :articles

  def initialize(dir_name = '/')
    @dir_name = dir_name
    @fs = ArticlesFileSystem.new(@dir_name)
    @articles = []
    load
  end

  def load
    @articles = @fs.load
  end

  def save
    @fs.save(@articles)
  end

  def new_article(title, body, author)
    article = Article.new(title, body, author)
    @articles << article
  end

  def longest_articles
    articles.sort { |x, y| y.length <=> x.length }
  end

  def best_articles
    articles.sort { |x, y| y.points <=> x.points }
  end

  def worst_articles
    articles.sort { |x, y| x.points <=> y.points }
  end

  def best_article
    raise NoArticlesFound unless articles.length > 0
    best_articles.first
  end

  def worst_article
    raise NoArticlesFound unless articles.length > 0
    worst_articles.first
  end

  def most_controversial_articles 
    articles.sort { |x, y| y.votes <=> x.votes }
  end
  def votes
    articles.map(&:votes).inject(0, &:+)
  end
  
  def authors
    articles.map(&:author).uniq
  end

  def authors_statistics
    author_stats = Hash.new(0)
    articles.each { |article| author_stats[article.author] += 1 }
    author_stats
  end

  def best_authors
    authors_statistics.sort_by { |key, value| value }
  end

  def best_author
    best_authors.last[0]
  end
  
  def search(query)
    articles.select { |article| article.contain?(query) }
  end
end

