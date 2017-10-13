include_recipe "rbenv::user"

execute "Install nodebrew" do
  user node[:user]
  command "curl -L git.io/nodebrew | perl - setup"
  not_if "[[ -e $HOME/.nodebrew/current/bin/nodebrew ]]"
end

execute "Install nodejs" do
  nodebrew = "$HOME/.nodebrew/current/bin/nodebrew"
  user node[:user]
  command "#{nodebrew} install-binary #{node[:nodejs][:version]} && #{nodebrew} use #{node[:nodejs][:version]}"
  not_if "[[ $(#{nodebrew} ls | grep current) =~ #{node[:nodejs][:version]} ]]"
end
