execute "Install Homebrew" do
  user node[:user]
  command '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  not_if 'test $(which brew)'
end
