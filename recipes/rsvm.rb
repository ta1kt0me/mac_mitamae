def home_dir
  node[:platform] == "darwin" ? "/Users" : "/home"
end

home_path = "#{home_dir}/" + node[:user]

# rust
execute "Install rsvm" do
  user node[:user]
  command "curl -L https://raw.github.com/sdepold/rsvm/master/install.sh | sh"
end

RSVM_HOME = home_path + "/.rsvm"
execute "Link fish-config for rsvm" do
  user node[:user]
  command "ln -s #{RSVM_HOME}/rsvm.fish $HOME/.config/fish/functions"
  not_if "test -e $HOME/.config/fish/functions/rsvm.fish"
end

node[:rust][:versions].each do |version|
  execute "Install rust #{version}" do
    user node[:user]
    cwd home_path
    command ". #{RSVM_HOME}/rsvm.sh && rsvm install #{version}"
    not_if ". #{RSVM_HOME}/rsvm.sh && test -n \"$(rsvm ls | grep #{version})\""
  end
end

node[:rust][:global].tap do |version|
  execute "Set rsvm use #{version}" do
    user node[:user]
    command ". #{RSVM_HOME}/rsvm.sh && rsvm use #{version}"
  end
end

node[:rust_packages].each do |package|
  execute "Install rust package: #{package}" do
    user node[:user]
    command ". #{RSVM_HOME}/rsvm.sh && cargo install #{package}"
    not_if ". #{RSVM_HOME}/rsvm.sh && test -n \"$(cargo install --list | grep #{package})\""
  end
end
