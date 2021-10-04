include_recipe 'directory_helper'

home_dir = DirectoryHelper.home(node)
commands = [
  { command: "ghq",  actual: "#{home_dir}/#{node[:user]}/go/#{node[:goenv][:global]}/bin/ghq" },
  { command: "fish", actual: "/usr/bin/fish" }
]

commands.each do |command|
  link "/usr/local/bin/#{command[:command]}" do
    to command[:actual]
    force true
  end
end
