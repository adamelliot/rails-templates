load_template "http://github.com/adamelliot/rails-templates/raw/master/base.rb"

plugin "preserve_attributes", :git => "git://github.com/adamelliot/preserve_attributes.git", :submodule => true  
plugin "paperclip", :git => "git://github.com/thoughtbot/paperclip.git", :submodule => true

if yes? "Setup Authlogic?"
  generate 'nifty_authentication'

  # Create a user for admin purposes
  if yes? "Create admin user? (Adds an admin column to the user table)"
    username = ask "Admin username?"
    password = ask "Admin password?"

    generate(:migration, "add_admin_to_users admin:boolean")

    # Create the admin user as a populate script
    file "01_admin_user.rb", <<-IGNORE
User.create_or_update(
  :id               => 1,
  :login            => "#{username}",
  :salt             => salt = User.unique_token,
  :crypted_password => Authlogic::CryptoProviders::BCrypt.encrypt("#{password}" + salt
  :email            => "admin@localhost"
  :admin            => true)
IGNORE
  end
end

if yes? "Add tagging?"
  plugin 'acts_as_taggable_redux', :git => 'git://github.com/monki/acts_as_taggable_redux.git', :submodule => true
  rake 'acts_as_taggable:db:create'
end

rake 'db:populate_and_migrate'

git :submodule => "init"
git :add => ".", :commit => '-m "Initial commit."'
