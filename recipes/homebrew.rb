execute "Install Homebrew" do
  user node[:user]
  command '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  not_if 'test -x /opt/homebrew/bin/brew || test -x /usr/local/bin/brew'
end
