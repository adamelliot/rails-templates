plugin "db-populate", :git => "git://github.com/ffmike/db-populate.git"

git :init

run "echo 'TODO Fill this shizzle with some Jangles' > README"
run "touch tmp/.gitignore tmp/.gitignore vendor/.gitignore"
run "cp config/database.yml config/example_database.yml"

dir "db/populate"
file ".gitignore", <<-IGNORE
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
IGNORE

git :add => ".", :commit => '-m "Initial commit."'