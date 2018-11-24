execute "apt-key add docker" do
  command "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -"
end

execute "add-apt-repository docker" do
  # ubuntu 18.10
  command "add-apt-repository \"deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu bionic stable\""
  not_if "test -n \"$(apt-cache policy | grep 'download.docker.com/linux/ubuntu bionic')\""
end

package "docker-ce"
