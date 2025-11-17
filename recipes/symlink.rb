include_recipe 'directory_helper'

commands = [
  { command: "fish", actual: "/usr/bin/fish" }
]

commands.each do |command|
  link "/usr/local/bin/#{command[:command]}" do
    to command[:actual]
    force true
  end
end
