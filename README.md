# Date Edge
## Website

http://dateedge.com

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

Profiles also has two lists of three properties.

**What I Am**:

- My diet
- My drug use
- My gender

**What I'm Looking For**:

- Their diet
- Their drug use
- Their gender

## Requirements

- [Ruby,  ~> 1.9.3](http://www.ruby-lang.org/)
- [Rails, ~> 4.0.2](https://github.com/rails/rails/)

## Installation

```bash
git clone git@github.com:veganstraightedge/dateedge-www.git
cd dateedge-www
bundle
```

#### Setup Database

```bash
cp config/database.yml.example config/database.yml
```

Update values to reflect your local environment.

#### Setup ENV vars

Create a .env file
```bash
touch .env
```

Add all required variables to `.env` using `doc/sample-dotenv` as a guide.

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
[file an issue](https://github.com/veganstraightedge/dateedge-www).

## License

Private business. Not for sharing. Yet.
