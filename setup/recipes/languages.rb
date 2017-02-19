include_recipe "rbenv::user"

execute "Install nodejs" do
  user node[:user]
  command "nodebrew install-binary #{node[:nodejs][:version]} && nodebrew use #{node[:ruby][:version]}"
  not_if "[[ $(nodebrew ls | grep current) =~ #{node[:nodejs][:version]} ]]"
end
