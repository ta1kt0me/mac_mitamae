# execute "apt-key add docker" do
#   command "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -"
# end
#
# execute "add-apt-repository docker" do
#   command "add-apt-repository \"deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\""
#   not_if "test -n \"$(apt-cache policy | grep 'download.docker.com/linux/ubuntu $(lsb_release -cs)')\""
# end
#
# package "docker-ce"
