# Archangel

**Archangel is currently under development. It is not ready for production use.**

[![Travis CI](https://travis-ci.org/archangel/archangel.svg?branch=master)](https://travis-ci.org/archangel/archangel)
[![Coverage Status](https://coveralls.io/repos/github/archangel/archangel/badge.svg?branch=master)](https://coveralls.io/github/archangel/archangel?branch=master)
[![Code Climate](https://codeclimate.com/github/archangel/archangel/badges/gpa.svg)](https://codeclimate.com/github/archangel/archangel)
[![Dependency Status](https://gemnasium.com/badges/github.com/archangel/archangel.svg)](https://gemnasium.com/github.com/archangel/archangel)

This project rocks and uses MIT-LICENSE.

## Table of contents

* [Requirements](#requirements)
* [Installation](#installation)
* [Updating](#updating)
* [Testing](#testing)
* [Contributing](#contributing)

## Requirements

- Ruby >= 2.2.2
- Rails >= 5.0

## Installation

Add to your application's Gemfile

```
gem "archangel", github: "archangel/archangel"
```

Run the bundle command

```
bundle install
```

Run the install generator

```
rails g archangel:install
```

Run the install generator with seed data

```
rails g archangel:install --seed
```

Seed data can be created separately by running `rake db:seed`

## Updating

Subsequent updates can be done by bumping the version in your Gemfile then adding the new migrations

```
rake archangel:install:migrations
```

Run migrations

```
rake db:migrate
```

## Testing

First, generate a dummy application. You will be required to generate a dummy application before running tests.

```
bundle exec rake dummy_app
```

Run tests

```
bundle exec rake
```

or

```
bundle exec rake spec
```

or

```
bundle exec rspec spec
```

You can also enable fail fast in order to stop tests at the first failure

```
bundle exec rspec spec --fail-fast
```

## Contributing

1. Fork it ( https://github.com/archangel/archangel/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
