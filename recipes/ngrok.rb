def home_dir
  node[:platform] == "darwin" ? "/Users" : "/home"
end

home_path = "#{home_dir}/" + node[:user]

execute "Make directory for local_bin" do
  user node[:user]
  command "mkdir -p #{home_path}/.local/bin"
  not_if "test -d #{home_path}/.local/bin"
end


# downloadリンクがubuntu
# jar コマンドがある前提
execute "Download ngrok" do
  user node[:user]
  cwd "#{home_path}/.local/bin"
  command "curl -sL -o - https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip | jar -xvf /dev/stdin && chmod +x ngrok"
  not_if "test -e #{home_path}/.local/bin/ngrok"
end

execute "Update ngrok" do
  user node[:user]
  command "#{home_path}/.local/bin/ngrok update"
end
