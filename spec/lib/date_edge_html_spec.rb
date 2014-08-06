require 'spec_helper'

describe DateEdgeHTML do
  describe "@usernames" do
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

  describe "#searches" do
    it "turns #search into a search link" do
      expect(Redcarpet::Markdown.new(DateEdgeHTML).render("I am #cool")).to include "<a href='/people?search=cool'>#cool</a>"
    end

    it "turns #search into a search link with numbers underscores and dashes" do
      expect(Redcarpet::Markdown.new(DateEdgeHTML).render("I am #cool_123-guy")).to include "<a href='/people?search=cool_123-guy'>#cool_123-guy</a>"
    end

    it "starts with # is still an h1" do
      expect(Redcarpet::Markdown.new(DateEdgeHTML).render("#Notice I am #cool")).to include "<h1>Notice"
    end
  end
end
