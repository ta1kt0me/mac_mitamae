execute "Create ghq symlink" do
  ghq_bin = ENV["HOME"] + "/src/bin/ghq"
  user node[:user]
  command "ln -s #{ghq_bin} /usr/local/bin/ghq"
  not_if "test -L /usr/local/bin/ghq"
end
