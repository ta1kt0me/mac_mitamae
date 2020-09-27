def home_dir
  node[:platform] == "darwin" ? "/Users" : "/home"
end

ssh_local = "#{home_dir}/" + node[:user] + "/.ssh_local"
known_hosts = "#{ssh_local}/known_hosts"

execute "create #{known_hosts}" do
  user node[:user]
  command "touch #{known_hosts}"
  not_if "test -e #{known_hosts}"
end
