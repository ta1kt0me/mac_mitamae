include_recipe 'directory_helper'

HOME_DIR = DirectoryHelper.home(node) + "/" + node[:user]

execute "Install eget" do
  user node[:user]
  command "curl https://zyedidia.github.io/eget.sh | sh && mv eget #{HOME_DIR}/.local/bin/"
end

node[:gh_repos].each do |repo|
  execute "Install #{repo} via eget" do
    user node[:user]
    command "#{HOME_DIR}/.local/bin/eget #{repo} --to #{HOME_DIR}/.local/bin"
  end
end