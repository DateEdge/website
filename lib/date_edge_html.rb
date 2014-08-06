class DateEdgeHTML < Redcarpet::Render::HTML
  def postprocess(html)
    autolink_at_usernames(html)
  end

  def autolink_at_usernames(html)
    html.gsub(/(@[\.a-zA-Z0-9_-]+)/) {|m| "<a href='/#{$1}'>#{$1}</a>" }
  end
end
