# typed: strict
module PostsHelper
  extend T::Sig

  sig {params(comment: Comment).returns(String)}
  def comment_html_body(comment)
    markdown_to_html(T.must(comment.body))
  end

  sig {params(code: Code).returns(String)}
  def code_html_body(code)
    markdown_to_html(T.must(code.body))
  end

  sig {params(rating: Rating).returns(String)}
  # Returns an HTML formatted string. Don't forget to use <tt>#html_safe</tt> !
  def rating_symbol(rating)
    case rating.rating.to_sym
    when :hateful
      <<-HTML.strip_heredoc
        <span style="color:#3778B7">H</span>
      HTML
    when :ambiguous
      <<-HTML.strip_heredoc
        <span style="color:#A56416">A</span>
      HTML
    when :benign
      <<-HTML.strip_heredoc
        <span style="color:#9B9B9B">B</span>
      HTML
    else
      ""
    end
  end

  sig {params(post: Post).returns(String)}
  def post_n_symbol(post)
    n = post.author_n
    author = post.author_
    last_n = author.last_post_n
    if n == last_n
      <<-HTML.strip_heredoc
        <span style="color:#A56416"><b>#{n}</b></span>
      HTML
    elsif n == 1
      <<-HTML.strip_heredoc
        <span style="color:#428226"><b>#{n}</b></span>
      HTML
    else
      <<-HTML.strip_heredoc
        <span style="color:#C7C4C2"><b>#{n}</b></span>
      HTML
    end
  end

  sig {params(comment: Comment).returns(String)}
  def comment_n_symbol(comment)
    n = comment.author_n
    author = comment.author_
    last_n = author.last_comment_n
    if n == last_n
      <<-HTML.strip_heredoc
        <span style="color:#A56416"><b>#{n}</b></span>
      HTML
    elsif n == 1
      <<-HTML.strip_heredoc
        <span style="color:#428226"><b>#{n}</b></span>
      HTML
    else
      <<-HTML.strip_heredoc
        <span style="color:#C7C4C2"><b>#{n}</b></span>
      HTML
    end
  end

  private

  sig {params(content: String).returns(String)}
  def markdown_to_html(content)
    MarkdownRenderService.render(CGI.unescapeHTML(content))
  end
end
