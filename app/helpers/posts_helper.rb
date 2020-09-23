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

  private

  sig {params(content: String).returns(String)}
  def markdown_to_html(content)
    MarkdownRenderService.render(CGI.unescapeHTML(content))
  end
end
