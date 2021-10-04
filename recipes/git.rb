include_recipe 'directory_helper'

home_dir = DirectoryHelper.home(node)
node[:git].each do |item|
  git "#{home_dir}/#{node[:user]}/#{item[:dist]}" do
    user node[:user]
    repository item[:repo]
  end
end
