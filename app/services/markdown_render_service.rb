# typed: strict

class MarkdownRenderService
  extend T::Sig

  sig {returns(Redcarpet::Markdown)}
  def self.renderer
    @renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(filter_html: true))
  end

  sig {params(text: String).returns(String)}
  def self.render(text)
    renderer.render(text)
  end
end
