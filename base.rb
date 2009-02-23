gem "thoughtbot-shoulda", :lib => 'shoulda', :source => 'http://gems.github.com'
gem "haml"
gem 'RedCloth', :lib => 'redcloth'

rake "gems:install", :sudo => true

git :init

run "haml --rails ."
run "echo 'TODO Fill this shizzle with some Jangles' > README"
run "touch tmp/.gitignore tmp/.gitignore vendor/.gitignore"
run "cp config/database.yml config/example_database.yml"
run "rm -f public/index.html public/javascripts"
run 'curl http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js > public/javascripts/jquery.js'

file "public/javascripts/application.js"
file "public/stylesheets/master.css"
file "config/initializers/haml.rb", <<-HAML
Haml::Template::options[:attr_wrapper] = '"'
HAML
  
file ".gitignore", <<-IGNORE
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
IGNORE

git :add => ".", :commit => '-m "Initial commit."'