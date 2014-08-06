require 'spec_helper'

describe DateEdgeHTML do
  it "turns @username into a link" do
    expect(Redcarpet::Markdown.new(DateEdgeHTML).render("@username")).to include "<a href='/@username'>@username</a>"
  end

  it "wraps text around it" do
    expect(Redcarpet::Markdown.new(DateEdgeHTML).render("Hi I am @username the user")).to include "Hi I am <a href='/@username'>@username</a> the user"
  end

  it "handles ., _, -, and numbers" do
    expect(Redcarpet::Markdown.new(DateEdgeHTML).render("@examp1e.boy_1-mccool")).to include "<a href='/@examp1e.boy_1-mccool'>@examp1e.boy_1-mccool</a>"
  end
end
