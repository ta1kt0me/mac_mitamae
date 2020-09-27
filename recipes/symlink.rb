def home_dir
  node[:platform] == "darwin" ? "/Users" : "/home"
end

commands = [
  { command: "ghq",  actual: "#{home_dir}/#{node[:user]}/go/#{node[:goenv][:global]}/bin/ghq" },
  { command: "fish", actual: "/usr/bin/fish" }
]

commands.each do |command|
  execute "Create #{command[:command]} symlink" do
    command "ln -s #{command[:actual]} /usr/local/bin/#{command[:command]}"
    not_if "test -L /usr/local/bin/#{command[:command]}"
  end
end
