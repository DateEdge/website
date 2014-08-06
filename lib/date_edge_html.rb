class DateEdgeHTML < Redcarpet::Render::HTML
  def postprocess(html)
    puts self.inspect
    html = autolink_at_usernames(html)
    autolink_searches(html)
  end

  def autolink_at_usernames(html)
    html.gsub(/(@[\.a-zA-Z0-9_-]+)/) {|m| "<a href='/#{$1}'>#{$1}</a>" }
  end

  def autolink_searches(html)
    html.gsub(/(#([\.a-zA-Z0-9_-]+))/) {|m| "<a href='/people?search=#{$2}'>#{$1}</a>" }
  end

end
