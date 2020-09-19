# typed: true
module PostsHelper
  extend T::Sig

  sig {params(comment: Comment).returns(String)}
  def comment_html_body(comment)
    body = CGI.unescapeHTML(comment.body)
    MarkdownRenderService.render(T.must(body))
  end
end
