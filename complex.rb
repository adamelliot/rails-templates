load_template "http://github.com/adamelliot/rails-templates/raw/master/base.rb"

plugin "paperclip", :git => "git://github.com/thoughtbot/paperclip.git", :submodule => true

#if yes? "Setup Authlogic?"
#  
#  # Create a user for admin purposes
#  if yes? "Create admin user?"
#    username = ask "Admin username?"
#    password = ask "Admin password?"
#  end
#else yes? "Create base admin page?"
#  # TODO: Create very simple static authentication
#end

# TODO: Authologic stuff