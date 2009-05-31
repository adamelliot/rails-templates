# This isn't working how I want...

load_template "/Users/adam/Code/rails/plugins/rails-templates/base.rb"

plugin "preserve_attributes", :git => "git://github.com/adamelliot/preserve_attributes.git", :submodule => true  
plugin "paperclip", :git => "git://github.com/thoughtbot/paperclip.git", :submodule => true

if yes? "Setup Authlogic?"
  reset = ""
  reset = "--password-reset" if yes? "Generate password resets?"

  gem "authlogic"
  generate "nifty_authentication #{reset}"

  # Create a user for admin purposes
  if yes? "Create admin user? (Adds an admin column to the user table)"
    username = ask "Admin username?"
    password = ask "Admin password?"

    generate(:migration, "add_admin_to_users admin:boolean")

    # Create the admin user as a populate script
    file "db/populate/01_admin_user.rb", <<-IGNORE
User.create_or_update(
  :id                    => 1,
  :login                 => "#{username}",
  :password              => "#{password}",
  :password_confirmation => "#{password}",
  :email                 => "#{username}@localhost.com",
  :admin                 => true)
IGNORE
  end
end

if yes? "Add tagging?"
  gem "mbleigh-acts-as-taggable-on", :source => "http://gems.github.com", :lib => "acts-as-taggable-on"
  rake "gems:install", :sudo => true
  generate :acts_as_taggable_on_migration
end

rake 'db:migrate_and_populate' 

git :submodule => "init"
git :add => ".", :commit => '-m "Initial commit."'
