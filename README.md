# Date Edge
## Website

http://dateedge.com

[![Build Status](https://travis-ci.org/DateEdge/website.svg?branch=master)](https://travis-ci.org/dateedge/website)
[![Code Climate](https://codeclimate.com/github/DateEdge/website.png)](https://codeclimate.com/github/DateEdge/website)

## Description

**[Date Edge](https://dateedge.com)**
is a Rails powered dating site with a very simple set of features.

- Profiles
- Photos
- Person to person messages
- Crushes
- Bookmarks

That's it. For now.

Profiles are simple free form text "bios" and unlimited photos with optional captions.

Profiles also have two lists of three properties.

**What I Am**:

- My diet
- My drug use
- My gender

**What I'm Looking For**:

- Their diet
- Their drug use
- Their gender

## Requirements

- [Ruby,  ~> 2.1.2](http://ruby-lang.org)
- [Rails, ~> 4.1.7](https://github.com/rails/rails)
- [ImageMagick](http://imagemagick.org) (`brew install imagemagick@6 && brew link --force imagemagick@6`)

## Installation

```bash
git clone git@github.com:DateEdge/website.git
cd website
bundle
```

#### Setup Database

```bash
cp config/database.example.yml config/database.yml
```

Update values to reflect your local environment.

#### Redis

```
brew install redis
```

#### Setup ENV vars

Create a .env file
```bash
touch .env
```

Add all required variables to `.env` using `doc/sample-dotenv` as a guide.

#### Import Production data

```bash
rake db:create
rake db:migrate
rake db:import
```

## Usage

```bash
foreman start -p 3000
```

## Authors

  * Shane Becker / [@veganstraightedge](https://github.com/veganstraightedge)
  * Bookis Smuin / [@bookis](https://github.com/bookis)

## Contribution

1. Fork it
2. Get it running
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Write your code and **specs**
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request

If you find bugs, have feature requests or questions, please
[file an issue](https://github.com/DateEdge/website).


## License

**PUBLIC DOMAIN**

Your heart is as free as the air you breathe. <br>
The ground you stand on is liberated territory.

In legal text, *Date Edge Ruby on Rails powered website* is dedicated to the public domain
using Creative Commons -- CC0 1.0 Universal.

[http://creativecommons.org/publicdomain/zero/1.0](http://creativecommons.org/publicdomain/zero/1.0 "Creative Commons &mdash; CC0 1.0 Universal")
