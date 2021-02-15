# nodebrew
execute "Install nodebrew" do
  user node[:user]
  command "curl -L git.io/nodebrew | perl - setup"
end

execute "Install nodejs" do
  nodebrew = "$HOME/.nodebrew/current/bin/nodebrew"
  user node[:user]
  command "#{nodebrew} install-binary #{node[:nodejs][:version]} && #{nodebrew} use #{node[:nodejs][:version]}"
  not_if "test -n \"$(#{nodebrew} ls | grep #{node[:nodejs][:version]})\""
end
