include_recipe 'directory_helper'

home_dir = DirectoryHelper.home(node)

execute "Install rustup" do
  user node[:user]
  command "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
end

home_path = "#{home_dir}/" + node[:user]
cargo_bin_path = home_path + "/.cargo/bin"
set_cargo_bin_to_path = "PATH=" + cargo_bin_path + ":$PATH"

node[:rust][:versions].each do |version|
  execute "Install rust #{version}" do
    user node[:user]
    command "#{set_cargo_bin_to_path} rustup install #{version}"
  end
end

node[:rust][:global].tap do |version|
  execute "Set default to #{version}" do
    user node[:user]
    command "#{set_cargo_bin_to_path} rustup default #{version}"
  end
end

node[:rust_packages].each do |package|
  execute "Install rust package: #{package}" do
    user node[:user]
    command "#{set_cargo_bin_to_path} cargo install #{package}"
  end
end

execute "Update rust packages" do
  user node[:user]
  command "#{set_cargo_bin_to_path} cargo install-update --all"
end
