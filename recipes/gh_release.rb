include_recipe 'directory_helper'

home_path = DirectoryHelper.home_path(node)
bin_path  = "#{home_path}/.local/bin"

execute "Install eget" do
  user node[:user]
  command "curl https://zyedidia.github.io/eget.sh | sh && mv eget #{bin_path}/"
end

node[:gh_repos].each do |repo|
  execute "Install #{repo} via eget" do
    user node[:user]
    command "#{bin_path}/eget #{repo} --to #{bin_path}"
  end
end
