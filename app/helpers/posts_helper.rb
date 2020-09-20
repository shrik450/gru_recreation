# typed: strict
module PostsHelper
  extend T::Sig

  sig {params(comment: Comment).returns(String)}
  def comment_html_body(comment)
    # CGI doesn't have type annotations, so this let is necessary to let Sorbet know.
    body = T.let(CGI.unescapeHTML(comment.body), T.nilable(String))
    MarkdownRenderService.render(T.must(body))
  end
end
