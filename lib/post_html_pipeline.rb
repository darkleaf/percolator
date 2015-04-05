PostHtmlPipeline =
  HTML::Pipeline.new [
    HTML::Pipeline::MarkdownFilter,
  ], gfm: true
