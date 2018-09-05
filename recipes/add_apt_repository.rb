node[:apt_repositories].each do |repo|
  execute "Install #{repo}" do
    command "add-apt-repository #{repo}"
    not_if "test -n \"$(apt-cache policy | grep #{repo.split(':')[1]})\""
  end
end
