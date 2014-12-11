# Epoch Bot

An IRC bot written in [Ruby](http://www.ruby-lang.org/en/) using the
[rubot](https://github.com/thorncp/rubot) framework. It has some _useful_
functions, but generally serves to provide breaks during the long, grueling
workday.

## Setup

### Ruby

Epoch Bot is written against [Ruby 1.9.2](http://rubyinstaller.org/downloads/).
Make sure the bin directory is in your path (I think there is an option for
this in the installer). Also, make sure to install the
[DevKit](http://rubyinstaller.org/downloads/).

### Bundler

Epoch Bot uses [Bundler](http://gembundler.com/) to manage dependencies. If you
don't yet have Bundler, install it with:

    gem install bundler

#### Installing Dependencies

To make sure all dependencies are installed, run

    bundle install

### Database

Epoch Bot uses the [Sequel](http://sequel.rubyforge.org/) ORM on top of [SQLite
3](http://www.sqlite.org/). To make sure your local schema is up to date, run

    bundle exec rake db:migrate

### Config

The configuration is conveniently located in the config.yml file. For running
locally, you should open this file and change the nick of the bot and put your
nick in the authorized_nicks section.

### Run It!

To execute the bot, simply run

    bundle exec rubot server
