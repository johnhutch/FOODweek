# FOODweek


# Purpose:

1. Store your favorite recipes
2. Use your stored recipes to create a weekly meal plan
3. Have your weekly meal plan generate a shopping list for you


We like food. We like lists. We don't like expending unecessary energy. Hopefully the convenience will one day offset the time, effort, and single malt we put into this bad boy.

---

# Development Setup

* Install xcode. Open xcode to say ok to whatever agreements.
* Open terminal, type: `xcode-select --install`
* Install homebrew:
    * `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
* `brew install openssl postgresql rbenv rbenv-vars ruby-build rbenv-gemset terminal-notifier`
* `brew services start postgresql`
* Add rbenv to bash so that it loads every time you open a terminal:
    * `echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile`
    * `source ~/.bash_profile`
* Install Ruby
    * `rbenv install 2.3.2`
    * `ruby -v`
* `gem update --system`
* `gem install bundler`
* `rbenv rehash` # Clears potential problem with bundler using the wrong `ruby`
* `git clone https://github.com/johnhutch/FOODweek.git`
* `cd FOODweek`
* `bundle install`
* Copy over config/application.yml and config/database.yml and replace with your local postgres values (just the username)
* `rake db:create db:migrate db:seed`
* `rake db:create db:migrate RAILS_ENV=test`
* `gem install rspec` # Should this be in the Gemfile?
* `rspec`
* `guard`
* hit enter after the guard prompt to start it running
* begin work to see errors as you change things

# Things we will eventually cover:

* Ruby version: 2.3.1

* System dependencies: 

* Configuration:

* Database creation:

* Database initialization

* How to run the test suite... super suite.

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions 

* What we want on our pizza
