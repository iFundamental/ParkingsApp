require 'minitest/autorun'
require './broken_example'

class ArticleTest < Minitest::Test
  def test_initialization
    article = Article.new('Test Title', 'This is the body of the article', 'The author')
    assert_kind_of(Article, article, msg = nil)
    assert_equal('Test Title', article.title)
    assert_equal('This is the body of the article', article.body)
    assert_equal('The author', article.author)
    assert_equal(0, article.likes)
    assert_equal(0, article.dislikes)
    assert_equal(Time.now.hour, article.created_at.hour, 'Created at time not set correctly, hour is incorrect')
    assert_equal(Time.now.min, article.created_at.min, 'Created at time not set correctly, miniutes are incorrect')
  end

  def test_initialization_with_anonymous_author
    article = Article.new('Test Title', 'This is the body of the article')
    assert_nil(article.author)
  end

  def test_liking
    article = Article.new('Test title', 'Test Body', 'The author')
    assert_equal(0, article.likes)

    article.like!
    assert_equal(1, article.likes)

    5.times { article.like! }
    assert_equal(6, article.likes)
  end

  def test_disliking
    article = Article.new('Test title', 'Test Body', 'The author')
    assert_equal(0, article.dislikes)

    article.dislike!
    assert_equal(1, article.dislikes)

    5.times { article.dislike! }
    assert_equal(6, article.dislikes)
  end

  def test_points
    article = Article.new('Test title', 'Test Body', 'The author')
    assert_equal(0, article.points)

    article.dislike!
    assert_equal(-1, article.points)

    5.times { article.dislike! }
    assert_equal(-6, article.points)

    5.times { article.like! }
    assert_equal(-1, article.points)

    5.times { article.like! }
    assert_equal(4, article.points)
  end

  def test_long_lines
    # returns array of lines greater 80 characters
    line5chars = '5' * 5
    line12chrs = '12c' * 4
    line80chrs = '80 c' * 20
    line400chrs = '400 ' * 100
    line120chrs = '120 ' * 30
    article = Article.new('Test title',line5chars + '\n' + line12chrs + '\n' + line80chrs + '\n' + line400chrs + '\n' + line120chrs, 'The author')
    longlines = [line80chrs, line400chrs, line120chrs]
    assert_equal(longlines, article.long_lines)
  end

  def test_truncate
    article = Article.new('Test title', 'Test Body', 'The author')
    assert_equal('T...', article.truncate(4))
  end

  def test_truncate_when_limit_is_longer_then_body
    article = Article.new('Test title', 'Test Body', 'The author')
    assert_equal('Test Body', article.truncate(100))
  end

  def test_truncate_when_limit_is_same_as_body_length
    article = Article.new('Test title', 'Test Body', 'The author')
    assert_equal('Test Body', article.truncate(9))
  end

  def test_length
    article = Article.new('Test title', 'Test Body', 'The author')
    assert_equal(9, article.length)
  end

  def test_votes
    article = Article.new('Test title', 'Test Body', 'The author')
    assert_equal(0, article.votes)

    article.dislike!
    assert_equal(1, article.votes)

    5.times { article.dislike! }
    assert_equal(6, article.votes)

    5.times { article.like! }
    assert_equal(11, article.votes)

    5.times { article.like! }
    assert_equal(16, article.votes)
  end

  def test_contain
    article = Article.new('Test title', 'Test Body', 'The author')
    assert_equal(true, article.contain?(/^Test/))
    assert_equal(false, article.contain?(/^Body/))
    assert_equal(true, article.contain?('Test'))
    assert_equal(false, article.contain?('Testing'))
  end
end

class ArticlesFileSystemTest < Minitest::Test
  def test_saving
    articles = []

    a1 =  Article.new('The happy programmer', 'Once apon a time there was a happy programmer', 'Sally Mclean')
    a1.likes = 3, a1.dislikes = 5
    articles << a1

    a2 =  Article.new('The rainy day', 'Today it is raining and cold', 'Greg Smith')
    a2.likes = 10, a2.dislikes = 4
    articles << a2

    fs = ArticlesFileSystem.new('.')
    fs.save(articles)

    assert_equal(true, File.file?('the_happy_programmer.article'), 'Expecting the file the_happy_programmer.article to exist')

    data = File.read('the_happy_programmer.article')
    assert_equal('Sally Mclean||3||5||Once apon a time there was a happy programmer', data)
  end

  def test_loading
    # article 1
    filename = 'the_happy_programmer.article'
    filebody = 'Sally Mclean||3||5||Once apon a time there was a happy programmer'
    File.open("#{filename}", 'w+') do |f|  
      f.write filebody
    end

    # article 2
    filename = 'the_rainy_day.article'
    filebody = 'Greg Smith||10||4||Today it is raining and cold'
    File.open("#{filename}", 'w+') do |f|  
      f.write filebody
    end

    fs = ArticlesFileSystem.new('.')
    articles = fs.load

    a1 = articles[0]
    a2 = articles[1]

    assert_equal('The happy programmer', a1.title)
    assert_equal(3, a1.likes)
    assert_equal(5, a1.dislikes)
    assert_equal('Once apon a time there was a happy programmer', a1.body)

    assert_equal('The rainy day', a2.title)
    assert_equal(10, a2.likes)
    assert_equal(4, a2.dislikes)
    assert_equal('Today it is raining and cold', a2.body)
  end
  MiniTest::Unit.after_tests do 
    File.delete('the_happy_programmer.article')
    File.delete('the_rainy_day.article')
  end
end

class WebPageTest < Minitest::Test
  def test_new_without_anything_to_load
    @a1 = WebPage.new('.')
    puts @a1.articles.to_s
    assert_equal(true, @a1.articles.empty?, msg = nil)
  end

  def test_new_article
    @a1 = WebPage.new('.')
    @a1.new_article('Test Title', 'Test Body', 'Test Author')
    assert_equal('Test Title', @a1.articles[0].title)
  end

  def test_longest_articles
    @a1 = WebPage.new('.')
    @a1.articles << @a1.new_article('Mid Size', 'middle size', 'Test Author')
    @a1.articles << @a1.new_article('Longest Article', 'This is a very long Article, longer that all the Others', 'Test Author')
    @a1.articles << @a1.new_article('Shortest Article', 'Short', 'Test Author')
    
    assert_equal('Longest Article', @a1.longest_articles.first.title)
    assert_equal('Mid Size', @a1.longest_articles[1].title)
    assert_equal('Shortest Article', @a1.longest_articles.last.title)
  end

  def test_best_articles
  end

  def test_best_article
  end

  def test_best_article_exception_when_no_articles_can_be_found
  end

  def test_worst_articles
  end

  def test_worst_article
  end

  def test_worst_article_exception_when_no_articles_can_be_found
  end

  def test_most_controversial_articles
  end

  def test_votes
  end

  def test_authors
  end

  def test_authors_statistics
  end

  def test_best_author
  end

  def test_search
  end
end

