execute "apt-key add docker" do
  command "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -"
end

execute "apt-apt-repository docker" do
  command "add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\""
end

package "docker-ce"
