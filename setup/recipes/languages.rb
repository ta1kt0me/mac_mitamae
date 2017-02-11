execute "Install Ruby" do
  user node[:user]
  command "rbenv install #{node[:ruby][:version]} && rbenv global #{node[:ruby][:version]}"
  not_if "[[ $(rbenv version) =~ #{node[:ruby][:version]} ]]"
end

execute "Install nodejs" do
  user node[:user]
  command "nodebrew install-binary #{node[:nodejs][:version]} && nodebrew use #{node[:ruby][:version]}"
  not_if "[[ $(nodebrew ls | grep current) =~ #{node[:nodejs][:version]} ]]"
end
