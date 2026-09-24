# Update tools to the latest. Run by bin/update, not by init.rb.

include_recipe 'directory_helper'
include_recipe 'mise_helper'

mise = MiseHelper.path(node)

execute "Update mise plugins" do
  user node[:user]
  command "#{mise} plugins update #{node[:mise][:plugins].join(' ')}"
end

execute "Update latest tools via mise" do
  user node[:user]
  command "#{mise} use --global #{MiseHelper.latest_tools(node).join(' ')}"
end

node[:gh_repos].each do |gh_repo|
  execute "Update #{gh_repo[:repo]} via eget" do
    user node[:user]
    command "#{DirectoryHelper.local_bin_path(node)}/eget --upgrade-only #{gh_repo[:repo]} --to #{DirectoryHelper.eget_bin_path(node, gh_repo)}"
  end
end

execute "Update vim's plugin" do
  user node[:user]
  command "vim -c 'PlugUpdate|q!|q!'"
end
