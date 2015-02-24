require 'minitest/autorun'
require './example'

class ArticleTest < Minitest::Test
  def test_initialization
    article = Article.new("Test Title", "This is the body of the article", "The author")
    assert_kind_of(Article, article, msg = nil)
    assert_equal("Test Title", article.title)
    assert_equal("This is the body of the article", article.body)
    assert_equal("The author", article.author)
    assert_equal(0,article.likes)
    assert_equal(0, article.dislikes)
    assert_equal(Time.now.hour, article.created_at.hour, "Created at time not set correctly, hour is incorrect")
    assert_equal(Time.now.min, article.created_at.min, "Created at time not set correctly, miniutes are incorrect")
  end

  def test_initialization_with_anonymous_author
    article = Article.new("Test Title", "This is the body of the article")
    assert_nil(article.author)
  end

  def test_liking
    article = Article.new("Test title", "Test Body", "The author")
    assert_equal(0,article.likes)
    article.like!
    assert_equal(1,article.likes)
    5.times{article.like!}
    assert_equal(6, article.likes)
  end

  def test_disliking
    article = Article.new("Test title", "Test Body", "The author")
    assert_equal(0,article.dislikes)
    article.dislike!
    assert_equal(1,article.dislikes)
    5.times{article.dislike!}
    assert_equal(6, article.dislikes)
  end

  def test_points
    article = Article.new("Test title", "Test Body", "The author")
    assert_equal(0,article.points)
    article.dislike!
    assert_equal(-1,article.points)
    5.times{article.dislike!}
    assert_equal(-6, article.points)
    5.times{article.like!}
    assert_equal(-1, article.points)
    5.times{article.like!}
    assert_equal(4, article.points)
  end

  def test_long_lines
    #returns array of lines greater 80 characters
    line5chars = "5" * 5
    line12chrs = "12c" * 4
    line80chrs = "80 c" * 20
    line400chrs = "400 " * 100
    line120chrs = "120 " * 30
    article = Article.new("Test title",line5chars + "\n" + line12chrs + "\n" + line80chrs + "\n" + line400chrs + "\n" + line120chrs, "The author")
    longlines = [line400chrs, line120chrs]
    assert_equal(longlines,article.long_lines)
  end

  def test_truncate
    article = Article.new("Test title", "Test Body", "The author")
    assert_equal("T...", article.truncate(4))

  end

  def test_truncate_when_limit_is_longer_then_body
    article = Article.new("Test title", "Test Body", "The author")
    assert_equal("Test Body", article.truncate(100))
  end

  def test_truncate_when_limit_is_same_as_body_length
    article = Article.new("Test title", "Test Body", "The author")
    assert_equal("Test Body", article.truncate(9))
  end

  def test_length
    article = Article.new("Test title", "Test Body", "The author")
    assert_equal(9, article.length)
  end

  def test_votes
    article = Article.new("Test title", "Test Body", "The author")
    assert_equal(0,article.votes)
    article.dislike!
    assert_equal(1,article.votes)
    5.times{article.dislike!}
    assert_equal(6, article.votes)
    5.times{article.like!}
    assert_equal(11, article.votes)
    5.times{article.like!}
    assert_equal(16, article.votes)
  end

  def test_contain
    article = Article.new("Test title", "Test Body", "The author")
    assert_equal(true, article.contain?(/^Test/))
    assert_equal(false, article.contain?(/^Body/))
    assert_equal(true, article.contain?("Test"))
    assert_equal(false, article.contain?("Testing"))
  end
end