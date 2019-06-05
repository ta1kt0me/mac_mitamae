tfenv = "#{ENV['HOME']}/.tfenv/bin/tfenv"
node[:tfenv][:versions].each do |version|
  execute "Install terraform #{version}" do
    user node[:user]
    command "PATH=#{ENV['HOME']}/.tfenv/bin:$PATH #{tfenv} install #{version}"
    not_if "test $(#{tfenv} list | grep #{version})"
  end
end

node[:tfenv][:global].tap do |version|
  execute "Set tfenv global #{version}" do
    user node[:user]
    command "PATH=#{ENV['HOME']}/.tfenv/bin:$PATH #{tfenv} use #{version}"
  end
end
