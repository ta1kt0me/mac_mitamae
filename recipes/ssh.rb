include_recipe 'directory_helper'

ssh_local = DirectoryHelper.home_path(node) + "/.ssh_local"
known_hosts = "#{ssh_local}/known_hosts"

execute "create #{known_hosts}" do
  user node[:user]
  command "touch #{known_hosts}"
  not_if "test -e #{known_hosts}"
end
