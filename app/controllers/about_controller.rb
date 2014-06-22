class AboutController < ApplicationController
  skip_before_filter :restrict_non_visible_user, only: [:terms, :privacy]

  def stats
    @slug  = "stats"
    @title = "Stats about Date Edge"

    # total counts
    @total_stats = [
      [
        [User.count,         "default", "users",     "People"   ],
        [Bookmark.count,     "warning", "star",      "Bookmarks"],
        [Crush.count,        "danger",  "heart",     "Crushes"  ]
      ],
      [
        [Photo.count,        "success", "picture-o", "Photos"],
        [Conversation.count, "info",    "envelope",  "Conversations"],
        [Message.count,      "info",    "comment",   "Messages"]
      ]
    ]

    # today counts
    @today_stats = [
      [
        [User.where(created_at: Date.today).count,         "default", "users",     "People"   ],
        [Bookmark.where(created_at: Date.today).count,     "warning", "star",      "Bookmarks"],
        [Crush.where(created_at: Date.today).count,        "danger",  "heart",     "Crushes"  ]
      ],
      [
        [Photo.where(created_at: Date.today).count,        "success", "picture-o", "Photos"],
        [Conversation.where(created_at: Date.today).count, "info",    "envelope",  "Conversations"],
        [Message.where(created_at: Date.today).count,      "info",    "comment",   "Messages"]
      ]
    ]

  end

  def terms
    @slug  = "about"
    @title = "Terms &amp; Conditions on Date Edge"
  end

  def privacy
    @slug = "privacy"
    @title = "Privacy Policy on Date Edge"
  end

  def us
    @slug  = "about"
    @title = "About Us, The Site and Code of Conduct"
  end

  def goodbye
    @slug  = "about"
    @title = "Goodbye, old friend! Come back anytime."
  end

  def grid
    @slug  = "grid"
    @title = "Everyone's Photo in One Big Grid for Screenshotting"
    @users = User.count
    render layout: false
  end
end
