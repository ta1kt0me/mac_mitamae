def home_dir
  node[:platform] == "darwin" ? "/Users" : "/home"
end

home_path = "#{home_dir}/" + node[:user]
bin_path = home_path + "/.local/bin"

ngrok_url = \
  node[:platform] == "darwin" ? \
    "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-darwin-amd64.zip" : \
    "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip"

execute "Make directory for local_bin" do
  user node[:user]
  command "mkdir -p #{bin_path}"
  not_if "test -d #{bin_path}"
end

# jar コマンドがある前提
execute "Download ngrok" do
  user node[:user]
  cwd "#{bin_path}"
  command "curl -sL -o - #{ngrok_url} | jar -xvf /dev/stdin && chmod +x ngrok"
  not_if "test -e #{bin_path}/ngrok"
end

execute "Update ngrok" do
  user node[:user]
  command "#{bin_path}/ngrok update"
end
