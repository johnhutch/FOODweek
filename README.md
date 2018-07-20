# FOODweek

## Elevator Pitch

Every week, I meal plan. Once a week, I sit down and pick out recipes for the next week whilst doing my food shopping on freshdirect. I may be checking what's on sale and googling for recipes. I may ask my wife or kids if they have they're in the mood for anything. I may just be sitting and wondering what haven't I made in a while. And in this process, I’m hopping between:

1. conversations with family
2. the grocery cart on fresh direct
3. googling recipes
4. a text file where I write out my meal plan

FOODweek is an online tool to help you do all that in one place. Well, most of it. It can't talk to your kids. That's on you.

# Purpose:

1. Store your favorite recipes
2. Use your stored recipes to create a weekly meal plan
3. Have your weekly meal plan generate a shopping list for you
4. Future: integrate with online grocery services to help you order your shopping list

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

# Info we still need to add here

* System dependencies: how to not get stymied installing nokogiri or readline on mac
* Configuration: how figaro grabs environment variables from heroku and set them up so your dev environment works
* Database creation and init: what's in the db seeds
* Running the test suite with guard
* Utilizing best TDD practices
* Heroku deployment instructions
