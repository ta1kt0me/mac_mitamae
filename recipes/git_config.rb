node[:git_config].each do |config|
  k = config[:key]
  v = config[:value]
  execute "Set git config #{k}" do
    command "git config --global --replace-all #{k} \"#{v}\""
    not_if "test $(git config --global --get #{k}) -eq \"#{v}\""
  end
end
