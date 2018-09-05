commands = [
  { command: "ghq",  actual: ENV["HOME"] + "/src/bin/ghq" },
  { command: "fish", actual: "/usr/bin/fish" },
]

commands.each do |command|
  execute "Create #{command[:command]} symlink" do
    command "ln -s #{command[:actual]} /usr/local/bin/#{command[:command]}"
    not_if "test -L /usr/local/bin/#{command[:command]}"
  end
end
