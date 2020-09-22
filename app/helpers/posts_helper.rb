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

  private

  sig {params(content: String).returns(String)}
  def markdown_to_html(content)
    MarkdownRenderService.render(CGI.unescapeHTML(content))
  end
end
