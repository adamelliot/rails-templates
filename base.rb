gem "thoughtbot-shoulda", :lib => 'shoulda', :source => 'http://gems.github.com'
gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :source => 'http://gems.github.com'
gem "haml"
gem 'RedCloth', :lib => 'redcloth'
gem "adamelliot-nifty-generators", :source => "http://gems.github.com", :lib => "nifty-generators"
 
rake "gems:install", :sudo => true
git :init

plugin 'will_paginate', :git => 'git://github.com/mislav/will_paginate.git', :submodule => true
plugin "db-populate", :git => "git://github.com/ffmike/db-populate.git", :submodule => true
file "db/populate/.gitignore"

run "haml --rails ."
run "echo 'TODO Fill this shizzle with some Jangles' > README"
run "touch tmp/.gitignore tmp/.gitignore vendor/.gitignore"
run "cp config/database.yml config/example_database.yml"
run "rm -rf public/index.html public/javascripts"
run 'curl http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js > public/javascripts/jquery.js'

file "public/javascripts/application.js"
file "public/stylesheets/sass/application.sass"
file "config/initializers/haml.rb", <<-HAML
Haml::Template::options[:attr_wrapper] = '"'
Sass::Plugin.options[:style] = :compressed
HAML
  
file ".gitignore", <<-IGNORE
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
db/*.db
IGNORE

generate :nifty_layout

git :submodule => "init"
git :add => ".", :commit => '-m "Initial commit."'
