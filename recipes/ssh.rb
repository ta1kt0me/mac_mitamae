include_recipe 'directory_helper'

ssh_local = DirectoryHelper.home_path(node) + "/.ssh_local"

file "#{ssh_local}/known_hosts" do
  user node[:user]
end
