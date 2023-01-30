execute "checkout the latest asdf" do
  user node[:user]
  command 'cd ~/.asdf && git checkout $(git tag -l --sort=-v:refname | head -n 1)'
end

execute "link completions" do
  user node[:user]
  command 'ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions/asdf.fish'
  not_if "test -s ~/.config/fish/completions/asdf.fish"
end

execute "asdf update" do
  user node[:user]
  command '~/.asdf/bin/asdf update'
end

asdf_command = ". ~/.asdf/asdf.sh && ~/.asdf/bin/asdf"

# supported https://github.com/asdf-vm/asdf-plugins
node[:asdf_packages].each do |package|
  execute "add plugin #{package[:name]}" do
    user node[:user]
    command "#{asdf_command} plugin add #{package[:name]}"
    not_if "~/.asdf/bin/asdf plugin list | grep -E '^#{package[:name]}$'"
  end

  execute "install plugin command #{package[:name]}" do
    user node[:user]
    command "#{asdf_command} install #{package[:name]} #{package[:version]}"
    not_if "~/.asdf/bin/asdf list #{package[:name]} | grep #{package[:version]}"
  end

  execute "update plugin command #{package[:name]}" do
    user node[:user]
    command "#{asdf_command} plugin update #{package[:name]} #{package[:version]} && #{asdf_command} global #{package[:name]} #{package[:version]}"
  end
end

# NOT supported https://github.com/asdf-vm/asdf-plugins
node[:asdf_with_url_packages].each do |package|
  execute "add plugin #{package[:name]} with url" do
    user node[:user]
    command "#{asdf_command} plugin add #{package[:name]} #{package[:url]}"
    not_if "~/.asdf/bin/asdf plugin list | grep -E '^#{package[:name]}$'"
  end

  execute "install external plugin command #{package[:name]}" do
    user node[:user]
    command "#{asdf_command} install #{package[:name]} #{package[:version]}"
    not_if "~/.asdf/bin/asdf list #{package[:name]} | grep -v 'No versions installed'"
  end
end
