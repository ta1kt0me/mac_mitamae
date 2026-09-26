include_recipe 'directory_helper'

node[:git_config].each do |config|
  k = config[:key]
  v = Shellwords.escape(DirectoryHelper.expand_home(node, config[:value].to_s))
  execute "Set git config #{k}" do
    command "git config --global --replace-all #{k} #{v}"
    not_if "test \"$(git config --global --get #{k})\" = #{v}"
  end
end
